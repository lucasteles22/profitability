class ReportService
  def initialize(input, current_user)
    @input = input
    @current_user = current_user
  end

  def call
    Report.transaction do
      reports = Extract::Earnings.call(@input, @current_user.id)
      Report.upsert_all(reports, unique_by: [ :kind, :date, :report_type, :product, :broker, :quantity, :user_id ])
    end
  end
end
