require "roo"

module Extract
  module Trading
    class Extractor
      def self.call(file, current_user_id)
        data = Roo::Spreadsheet.open(file)
        tradings = []

        data.each_row_streaming(pad_cells: true, offset: 1) do |row|
          tradings << Mapper.to_report(row).merge({ user_id: current_user_id })
        end

        tradings
      end
    end
  end
end
