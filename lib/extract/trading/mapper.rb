module Extract
  module Trading
    class Mapper
      TRADING_DATE = 0
      KIND         = 1
      MARKET_TYPE  = 2
      BROKER       = 4
      CODE         = 5
      QUANTITY     = 6
      UNIT_PRICE   = 7
      TOTAL_VALUE  = 8

      def self.to_trading(row)
        {
          trading_date: row[TRADING_DATE].value,
          kind: row[KIND].value,
          market_type: row[MARKET_TYPE].value,
          code: row[CODE].value,
          broker: row[BROKER].value,
          quantity: row[QUANTITY].value,
          unit_price: row[UNIT_PRICE].value,
          total_value: row[TOTAL_VALUE].value
        }
      end
    end
  end
end
