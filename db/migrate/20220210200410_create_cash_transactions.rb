class CreateCashTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_transactions do |t|
      t.string :description
      t.date :date
      t.float :value
      t.references :funds, null: false, foreign_key: true

      t.timestamps
    end
  end
end
