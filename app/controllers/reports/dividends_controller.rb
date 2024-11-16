class Reports::DividendsController < ActionController::API
  before_action :authenticate_user!

  def index
    render :index, locals: { dividends: Reports::DividendService.new(current_user).() }
  end
end
