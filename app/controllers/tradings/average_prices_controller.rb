class Tradings::AveragePricesController < ActionController::API
  before_action :authenticate_user!

  def index
    stocks = Tradings::AveragePriceService.new(current_user).()

    render :index, locals: { stocks: stocks }
  end
end
