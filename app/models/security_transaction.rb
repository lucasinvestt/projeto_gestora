class SecurityTransaction < ApplicationRecord
  belongs_to :fund
  belongs_to :security

  def self.portfolio(fund_id, date)
    all
    .select("security_id, sum(security_transactions.amount) as totalAmount")
    .group("security_id")
    .where(fund_id: fund_id)
    .where("date <= ? ", date)
    .having("sum(security_transactions.amount) <> 0")
    .includes(:security)
  end 

  def self.securitiesTransactionsFromDate(fund_id, date)
    all
    # .select("amount, unit_value")
    .where(fund_id: fund_id)
    .where(date: date)
  end

  def self.allSecuritiesTransactionsFromDate(date)
    all.where(date: date)
  end

  # def as_json(_option)
  #   super({
  #     only: [:totalamount, :amount, :unit_value],
  #     include: {
  #       security: {
  #         only: [:id, :name, :security_type, :isin]
  #       }
  #     }
  #   }.merge(_option))
  # end

  #   def as_json(_option)
  #   super({
  #     only: [:totalamount, :amount, :unit_value],
  #     include: {
  #       security: {
  #         only: [:id, :name, :security_type]
  #       },
  #       fund: {
  #         only: [:id, :name]
  #       }
  #     }
  #   }.merge(_option))
  # end

end
