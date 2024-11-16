class ReportsController < ActionController::API
  before_action :authenticate_user!

  def index
    reports = Report.order(report_date: :desc).page(0)

    render :index, locals: { reports: reports }
  end

  def create
    ReportService.new(create_params.path, current_user).()

    head :created
  end

  def create_params
    params.require(:file)
  end
end
