class AveragePrice
  attr_accessor :product, :total_cost_basis, :quantity, :position_quantity

  def initialize(product, total_cost_basis, quantity, position_quantity)
    @product = product
    @total_cost_basis = total_cost_basis
    @quantity = quantity
    @position_quantity = position_quantity
  end

  def average_price
    @total_cost_basis / @quantity
  end
end
