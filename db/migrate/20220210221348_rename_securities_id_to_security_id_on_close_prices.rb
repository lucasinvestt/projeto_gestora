class RenameSecuritiesIdToSecurityIdOnClosePrices < ActiveRecord::Migration[7.0]
  def change
    rename_column :close_prices, :securities_id, :security_id
  end
end
