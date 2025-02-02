class TradingsController < ActionController::API
  before_action :authenticate_user!

  def create
    TradingService.new(create_params.path, current_user).()

    head :created
  end

  private

  def create_params
    params.require(:file)
  end
end
