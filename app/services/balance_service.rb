class BalanceService
  def initialize(current_user)
    @current_user = current_user
  end

  def call
    user_report = Report.with_user(@current_user)

    credit = sum { user_report.credit }
    debit = sum { user_report.debit }

    Balance.new(credit, debit)
  end

  private

  def sum(&block)
    Thread.new do
      if block_given?
        yield.sum(:total_value)
      end
    end.value
  end
end
