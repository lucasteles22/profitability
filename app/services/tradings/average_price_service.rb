class Tradings::AveragePriceService
  def initialize(current_user)
    @current_user = current_user
  end

  def call
    average_price = query { ActiveRecord::Base.connection.execute(query_avg_price) }
    stock_bonus = query { ActiveRecord::Base.connection.execute(query_stock_bonus) }

    map_to_average_price(average_price.value, stock_bonus.value)
  end

  private

  def query(&block)
    Thread.new do
      if block_given?
        yield
      end
    end
  end

  def query_avg_price
    query = <<-SQL
      WITH trading AS (
        SELECT SUM(total_value) AS "total_value", SUM(quantity) AS "quantity", RTRIM(code, 'F') AS "code"
        FROM tradings
        WHERE user_id = #{@current_user.id}
        AND kind ilike '%compra%'
        GROUP BY quantity, RTRIM(code, 'F')
      ),
      position AS (
        SELECT RTRIM(code, 'F') AS "code", SUM(CASE WHEN kind ILIKE '%compra%' THEN quantity ELSE -quantity END) AS "quantity"
        FROM tradings
        GROUP BY quantity, RTRIM(code, 'F')
      )
      SELECT trading.code AS "product", SUM(trading.total_value) AS "total_value", SUM(trading.quantity) AS quantity
      FROM trading
      WHERE trading.code IN (
        SELECT position.code
        FROM position
        GROUP BY position.code
        HAVING SUM(position.quantity) > 0
      )
      GROUP BY trading.code
      ORDER BY trading.code ASC;
    SQL
  end

  def query_stock_bonus
    query = <<-SQL
      WITH stock_bonus AS (
        SELECT RTRIM(product, 'F') AS "code", SUM(total_value) AS "total_value", SUM(quantity) AS "quantity"
        FROM transactions
        WHERE transaction_type ILIKE '%boni%'
        AND user_id = #{@current_user.id}
        GROUP BY quantity, RTRIM(product, 'F')
        HAVING SUM(total_value) > 0
      )
      SELECT stock_bonus.code AS "product", SUM(stock_bonus.total_value) AS "total_value", SUM(stock_bonus.quantity) AS quantity
      FROM stock_bonus
      GROUP BY stock_bonus.code
      ORDER BY stock_bonus.code ASC;
    SQL
  end

  def map_to_average_price(average_price, stock_bonus)
    products = []
    average_price&.each do |row|
      code = row["product"]
      stock = stock_bonus&.find { |x| x["product"]&.start_with?(code) }
      total_value = row["total_value"] + (stock.present? ? stock["total_value"] : 0)
      quantity = row["quantity"] + (stock.present? ? stock["quantity"] : 0)

      products << AveragePrice.new(code, (total_value / quantity), quantity.to_i)
    end

    products
  end
end
