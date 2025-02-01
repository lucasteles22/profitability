class Tradings::AveragePriceService
  def initialize(current_user)
    @current_user = current_user
  end

  def call
    result = ActiveRecord::Base.connection.execute(query)
    map_to_average_price(result)
  end

  private

  def query
    query = <<-SQL
      WITH trading AS (
        SELECT SUM(total_value) AS "total_value", SUM(quantity) AS "quantity", RTRIM(code, 'F') AS "code"
        FROM tradings
        WHERE user_id = #{@current_user.id}
        AND kind ilike '%compra%'
        GROUP BY quantity, RTRIM(code, 'F')
      )
      SELECT trading.code AS "product", (SUM(trading.total_value) / SUM(trading.quantity)) AS "average_price"
      FROM trading
      GROUP BY trading.code
      ORDER BY trading.code ASC;
    SQL
  end

  def map_to_average_price(result)
    products = []
    result.to_a.each do |row|
      products << AveragePrice.new(row["product"], row["average_price"])
    end

    products
  end
end
