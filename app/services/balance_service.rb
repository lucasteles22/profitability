class BalanceService
  def initialize(current_user)
    @current_user = current_user
  end

  def call
    credit = Report.credit.with_user(@current_user).sum(:total_value)
    debit = Report.debit.with_user(@current_user).sum(:total_value)
    balance = credit - debit

    { credit: credit, debit: debit, balance: balance }
  end
end
