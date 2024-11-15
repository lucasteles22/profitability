json.array! reports do |report|
  json.kind report.kind
  json.report_date report.report_date
  json.report_type report.report_type
  json.product report.product
  json.broker report.broker
  json.quantity report.quantity
  json.unit_price report.unit_price
  json.total_value report.total_value
end
