class CreateSecurities < ActiveRecord::Migration[7.0]
  def change
    create_table :securities do |t|
      t.string :name
      t.string :type
      t.string :isin

      t.timestamps
    end
  end
end
