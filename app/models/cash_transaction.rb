class CashTransaction < ApplicationRecord
  belongs_to :fund

  def self.fund_balance(fund_id, date)
    all.select("fund_id, sum(cash_transactions.value) as totalValue")
    .group("fund_id")
    .where(fund_id: fund_id)
    .where("date <= ?", date)
  end

end
