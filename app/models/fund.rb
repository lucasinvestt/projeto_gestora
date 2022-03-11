class Fund < ApplicationRecord
    has_many :cash_transactions
    has_many :security_transactions

    def self.getSecuritiesTotalValue(fund_id, date)
        # SELECT sum(amount*cp.value) as totalsum
        # FROM security_transactions st
        # INNER JOIN close_prices cp ON st.security_id = cp.security_id
        # WHERE st.fund_id = 1 and cp.date = ontem
        # GROUP BY st.fund_id;

        SecurityTransaction.all
        .joins("INNER JOIN close_prices ON security_transactions.security_id = close_prices.security_id")
        .select("sum(security_transactions.amount*close_prices.value) as totalsum")
        .group("security_transactions.fund_id")
        .where(fund_id: fund_id)
        .where("close_prices.date = ?", date)
        .where("security_transactions.date <= ?", date)

    end

    def self.getFundPL(fund_id, date)
        securities_value = Fund.getPortfolioWithClosePrices(fund_id, date)
        fund_balance = CashTransaction.fund_balance(fund_id, date)

        fund_balance = fund_balance[0] ? fund_balance[0].balance : 0

        securities_value_sum = 0
        securities_value.each do |item|
            securities_value_sum += item['value'] * item['amount']
        end

        pl = fund_balance + securities_value_sum
        
        
        # securities_value = Fund.getSecuritiesTotalValue(fund_id, date)
        # fund_balance = CashTransaction.fund_balance(fund_id, date)

        # fund_balance = fund_balance[0] ? fund_balance[0].balance : 0
        # securities_value_sum = securities_value[0] ? securities_value[0].totalsum : 0
        # pl = fund_balance + securities_value_sum

        plInfo = {
            "fund_id": fund_id,
            "pl": pl,
        }

        return plInfo
    end

    def self.getPortfolioWithClosePrices(fund_id, date)
        # SecurityTransaction
        # .all
        # .joins("INNER JOIN close_prices ON security_transactions.security_id = close_prices.security_id")
        # .joins("INNER JOIN securities ON securities.id = security_transactions.security_id")
        # .select("securities.name, securities.symbol, sum(security_transactions.amount) as SecurityCount, close_prices.value as close_price")
        # .group("security_transactions.fund_id, securities.name, close_prices.value, securities.symbol")
        # .where(fund_id: fund_id)
        # .where("close_prices.date = ?", date)
        # .where("security_transactions.date <= ?", date)
        
        securities = SecurityTransaction
            .all
            .select('sum(amount) as sum, security_id')
            .group('security_id')
            .where(fund_id: fund_id)
            .where("date <= ?", date)
        
        teste = []
        securities.each do |security|                
            opa = ClosePrice.all.select('value, security_id')
                .where(security_id: security.security_id)
                .where("date <= ?", date)
                .order("date desc")
                .limit(1)
                .as_json(only: [:value, :security_id], include: {
                    security: {
                      only: [:symbol, :security_type]
                    },
                  })
            
            opa[0]['amount'] = security.sum
            teste.push(opa[0])
        end
        
        return teste
        # return securities
    end

end
