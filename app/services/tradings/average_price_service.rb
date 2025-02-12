class Tradings::AveragePriceService
  def initialize(current_user)
    @current_user = current_user
  end

  def call
    tradings = query { ActiveRecord::Base.connection.execute(query_trading) }
    stock_bonus = query { ActiveRecord::Base.connection.execute(query_stock_bonus) }

    map_to_average_price(tradings.value, stock_bonus.value)
  end

  private

  def query(&block)
    Thread.new do
      if block_given?
        yield
      end
    end
  end

  def query_trading
    query = <<-SQL
      WITH trading AS (
        SELECT SUM(CASE WHEN kind ILIKE '%compra%' THEN total_value ELSE 0 END) AS "total_purchase_price",
          SUM(CASE WHEN kind not ILIKE '%compra%' THEN total_value ELSE 0 END) AS "total_sale_price",
          SUM(CASE WHEN kind ILIKE '%compra%' THEN quantity ELSE 0 END) AS "total_purchase_quantity",
          SUM(CASE WHEN kind not ILIKE '%compra%' THEN quantity ELSE 0 END) AS "total_sale_quantity",
          RTRIM(code, 'F') AS "code"
        FROM tradings
        WHERE user_id = #{@current_user.id}
        GROUP BY quantity, RTRIM(code, 'F')
      )
      SELECT trading.code AS "product",
        SUM(trading.total_purchase_price) AS "total_purchase_price",
        SUM(trading.total_sale_price) AS "total_sale_price",
        SUM(trading.total_purchase_quantity) AS "total_purchase_quantity",
        SUM(trading.total_sale_quantity) AS "total_sale_quantity",
        (SUM(trading.total_purchase_price) / SUM(trading.total_purchase_quantity)) as "average_price"
      FROM trading
      GROUP BY trading.code
      HAVING (SUM(total_purchase_quantity) - SUM(total_sale_quantity)) > 0
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

  def map_to_average_price(tradings, stock_bonus)
    products = []
    tradings&.each do |row|
      code = row["product"]
      stock = stock_bonus&.find { |x| x["product"]&.start_with?(code) }

      total_cost_basis = row["total_purchase_price"] + (stock.present? ? stock["total_value"] : 0)
      quantity = row["total_purchase_quantity"] + (stock.present? ? stock["quantity"] : 0)
      position_quantity = quantity - row["total_sale_quantity"]

      products << AveragePrice.new(code, total_cost_basis, quantity, position_quantity)
    end

    products
  end
end
