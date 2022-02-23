class RenameIsinToSymbolInSecurities < ActiveRecord::Migration[7.0]
  def change
    rename_column :securities, :isin, :symbol
  end
end
