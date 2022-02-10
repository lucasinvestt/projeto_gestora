class CreateClosePrice < ActiveRecord::Migration[7.0]
  def change
    create_table :close_prices do |t|
      t.date :date
      t.float :value
      t.references :securities, null: false, foreign_key: true

      t.timestamps
    end
  end
end
