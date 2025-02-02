class AveragePrice
  attr_accessor :product, :average_price, :quantity

  def initialize(product, average_price, quantity)
    @product = product
    @average_price = average_price
    @quantity = quantity
  end
end
