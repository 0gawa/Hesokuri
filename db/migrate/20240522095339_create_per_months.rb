class CreatePerMonths < ActiveRecord::Migration[7.0]
  def change
    create_table :per_months do |t|
      t.integer :month, null: false
      t.integer :year, null: false
      t.integer :spend_money, null: false
      t.integer :income_money, null: false
      t.integer :sum_money, null: false

      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
  end
end
