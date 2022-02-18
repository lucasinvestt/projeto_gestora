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

  def as_json(_option)
    super({
      only: [:totalamount],
      include: {
        security: {
          only: [:id, :name, :security_type, :isin]
        }
      }
    })
  end

end
