json.array! stocks do |stock|
  json.product stock.product
  json.average_price stock.average_price.round(2)
  json.quantity stock.quantity
end
