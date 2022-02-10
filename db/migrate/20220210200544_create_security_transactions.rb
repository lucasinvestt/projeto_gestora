class CreateSecurityTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :security_transactions do |t|
      t.date :date
      t.integer :amount
      t.float :unit_value
      t.references :funds, null: false, foreign_key: true
      t.references :securities, null: false, foreign_key: true

      t.timestamps
    end
  end
end
