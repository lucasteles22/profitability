class Transactions::DividendService
  def initialize(current_user)
    @current_user = current_user
  end

  def call
    # Somente FII
    Transaction.select(:product, "sum(total_value) as total_value")
      .where("transacion ilike '%rendimento%'")
      .group(:product)
  end
end
