class CreateIncomes < ActiveRecord::Migration[7.0]
  def change
    create_table :incomes do |t|
      t.integer :money, null: false
      t.string :comment

      t.references :user, foreign_key: true, null: false
      
      t.timestamps
    end
  end
end
