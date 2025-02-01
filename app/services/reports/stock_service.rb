class Reports::StockService
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
      WITH average_purchase_price as (
        SELECT SUM(total_value) as total_value, report_type, quantity, product
        FROM reports
        WHERE report_type ILIKE '%Transferência - Liquidação%'
        AND kind = 'Credito'
        AND user_id = #{@current_user.id}
        GROUP BY report_type, quantity, product
      )
      SELECT average_purchase_price.product as "product", (SUM(average_purchase_price.total_value) / SUM(average_purchase_price.quantity)) as "average_price"
      FROM average_purchase_price
      GROUP BY average_purchase_price.product
      ORDER BY average_purchase_price.product ASC;
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
