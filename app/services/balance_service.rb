class BalanceService
  def initialize(current_user)
    @current_user = current_user
  end

  def call
    user_transaction = Transaction.with_user(@current_user)

    credit = sum { user_transaction.credit }
    debit = sum { user_transaction.debit }

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
