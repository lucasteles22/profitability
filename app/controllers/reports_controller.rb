class ReportsController < ActionController::API
  before_action :authenticate_user!

  def create
    ReportService.new(create_params.path, current_user).()

    render status: :created
  end

  def create_params
    params.require(:file)
  end
end
