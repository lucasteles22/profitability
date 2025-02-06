class TransactionService
 def initialize(input, current_user)
    @input = input
    @current_user = current_user
  end

  def call
    Transaction.transaction do
      transactions = Extract::Transaction::Extractor.(@input, @current_user.id)
      Transaction.upsert_all(transactions, unique_by: [ :kind, :transaction_date, :transaction_type, :product, :broker, :quantity, :user_id, :unit_price, :total_value ])
    end
  end
end
