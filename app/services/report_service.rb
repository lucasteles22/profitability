class ReportService
  def initialize(input, current_user)
    @input = input
    @current_user = current_user
  end

  def call
    Report.transaction do
      reports = Extract::Earning::Extractor.(@input, @current_user.id)
      Report.upsert_all(reports, unique_by: [ :kind, :report_date, :report_type, :product, :broker, :quantity, :user_id, :unit_price, :total_value ])
    end
  end
end
