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

    end

    def self.getFundPL(fund_id, date)
        securities_value = Fund.getSecuritiesTotalValue(fund_id, date)
        fund_balance = CashTransaction.fund_balance(fund_id)

        plInfo = {
            "fund_id": fund_id,
            "fund_balance": fund_balance[0].totalvalue,
            "all_securities_value": securities_value[0].totalsum
        }

        return plInfo
    end

end
