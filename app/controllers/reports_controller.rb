class ReportsController < ActionController::API
  def create
    render status: :created
  end
end
