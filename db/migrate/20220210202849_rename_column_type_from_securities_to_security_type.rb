class RenameColumnTypeFromSecuritiesToSecurityType < ActiveRecord::Migration[7.0]
  def change
    rename_column :securities, :type, :security_type
  end
end
