class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name, null: false
      t.integer :brand, null: false
      t.string :purpose, default: ""

      t.references :user, foreign_key: true, null: false
      
      t.timestamps
    end
  end
end
