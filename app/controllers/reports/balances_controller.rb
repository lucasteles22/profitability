class Reports::BalancesController < ActionController::API
  before_action :authenticate_user!

  def show
    balance = BalanceService.new(current_user).()

    render :show, locals: { balance: balance }
  end
end
