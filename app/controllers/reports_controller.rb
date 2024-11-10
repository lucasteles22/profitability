class ReportsController < ActionController::API
  def create
    response = Extract::Earnings.call(create_params.path)

    render status: 204 if response
    render status: 422
  end

  def create_params
    params.require(:file)
  end
end
