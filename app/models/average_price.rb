class AveragePrice
  attr_accessor :product, :average_price

  def initialize(product, average_price)
    @product = product
    @average_price = average_price
  end
end
