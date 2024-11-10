class ReportService
  def initialize(input)
    @input = input
  end

  def call
    reports = Extract::Earnings.call(@input)
    Report.transaction do
      reports.each do |report|
        report.save!
      end
    end
  end
end
