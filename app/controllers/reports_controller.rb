class ReportsController < ActionController::API
  def create
    ReportService.new(create_params.path).call

    render status: :created
  end

  def create_params
    params.require(:file)
  end
end
