class Balance
  def initialize(credit, debit)
    @credit = credit
    @debit = debit
  end

  def value
    @debit - @credit
  end
end
