require "roo"

module Extract
  class Earnings
    def self.call(file, current_user_id)
      data = Roo::Spreadsheet.open(file)
      reports = []

      data.each_row_streaming(pad_cells: true, offset: 1) do |row|
        reports << Mapper.to_report(row).merge({ user_id: current_user_id })
      end

      reports
    end
  end
end
