class TradingService
  def initialize(input, current_user)
    @input = input
    @current_user = current_user
  end

  def call
    Trading.transaction do
      tradings = Extract::Trading::Extractor.(@input, @current_user.id)
      Trading.upsert_all(tradings, unique_by: [ :user_id, :kind, :trading_date, :market_type, :code, :broker, :quantity, :unit_price, :total_value ])
    end
  end
end
