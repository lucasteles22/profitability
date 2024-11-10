
module Extract
  class Mapper
    ENTRADA_SAIDA  = 0
    DATA           = 1
    MOVIMENTACAO   = 2
    PRODUTO        = 3
    CORRETORA      = 4
    QUANTIDADE     = 5
    PRECO_UNITARIO = 6
    VALOR_OPERACAO = 7

    def self.to_report(row)
      p row
      Report.new(
        kind: row[ENTRADA_SAIDA],
        date: row[DATA].value,
        type: row[MOVIMENTACAO],
        product: row[PRODUTO],
        broker: row[CORRETORA],
        quantity: row[QUANTIDADE].value,
        unit_price: row[PRECO_UNITARIO].value,
        total_value: row[VALOR_OPERACAO].value,
      )
    end
  end
end
