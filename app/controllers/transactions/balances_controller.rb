class Transactions::BalancesController < ActionController::API
  before_action :authenticate_user!

  def show
    render :show, locals: { balance: BalanceService.new(current_user).() }
  end
end
