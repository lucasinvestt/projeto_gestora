class RenameForeignKeysOnSecurityTransactionsToSingular < ActiveRecord::Migration[7.0]
  def change
    rename_column :security_transactions, :funds_id, :fund_id
    rename_column :security_transactions, :securities_id, :security_id
  end
end
