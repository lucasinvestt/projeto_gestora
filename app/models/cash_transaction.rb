class CashTransaction < ApplicationRecord
  belongs_to :fund

  def self.fund_balance(fund_id, date)
    all.select("fund_id, sum(cash_transactions.value) as balance")
    .where(fund_id: fund_id)
    .where("date <= ?", date)
    .group("fund_id")
  end

  def self.getCashTransactionsFromDate(fund_id, date)
    all
    .select("id, description, value")
    .where(fund_id: fund_id)
    .where(date: date)
  end

  def self.getAllCashTransactionsFromDate(date) 
    all
    .where(date: date)
  end

end
