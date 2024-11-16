class Reports::DividendService
  def initialize(current_user)
    @current_user = current_user
  end

  def call
    # Somente FII
    Report.select(:product, "sum(total_value) as total_value")
      .where("report_type ilike '%rendimento%'")
      .group(:product)
  end
end
