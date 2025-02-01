class Reports::StocksController < ActionController::API
  before_action :authenticate_user!

  def average_price
    stocks = Reports::StockService.new(current_user).()
    render :average_price, locals: { stocks: stocks }
  end
end
