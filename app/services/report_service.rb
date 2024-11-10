class ReportService
  def initialize(input)
    @input = input
  end

  def call
    Report.transaction do
      reports = Extract::Earnings.call(@input)
      Report.upsert_all(reports, unique_by: [ :kind, :date, :report_type, :product, :broker, :quantity ])
    end
  end
end
