module Extract
  module Transaction
    class Mapper
      ENTRADA_SAIDA  = 0
      DATA           = 1
      MOVIMENTACAO   = 2
      PRODUTO        = 3
      CORRETORA      = 4
      QUANTIDADE     = 5
      PRECO_UNITARIO = 6
      VALOR_OPERACAO = 7

      def self.to_transaction(row)
        {
          kind: row[ENTRADA_SAIDA].value,
          transaction_date: row[DATA].value,
          transaction_type: row[MOVIMENTACAO].value,
          product: row[PRODUTO].value,
          broker: row[CORRETORA].value,
          quantity: row[QUANTIDADE].value,
          unit_price: row[PRECO_UNITARIO].value,
          total_value: row[VALOR_OPERACAO].value
        }
      end
    end
  end
end
