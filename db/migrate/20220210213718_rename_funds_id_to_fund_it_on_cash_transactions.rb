class RenameFundsIdToFundItOnCashTransactions < ActiveRecord::Migration[7.0]
  def change
    rename_column :cash_transactions, :funds_id, :fund_id
  end
end
