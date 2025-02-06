require "roo"

module Extract
  module Transaction
    class Extractor
      def self.call(file, current_user_id)
        data = Roo::Spreadsheet.open(file)
        transactions = []

        data.each_row_streaming(pad_cells: true, offset: 1) do |row|
          transactions << Mapper.to_transaction(row).merge({ user_id: current_user_id })
        end

        transactions
      end
    end
  end
end
