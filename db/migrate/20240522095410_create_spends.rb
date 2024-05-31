class CreateSpends < ActiveRecord::Migration[7.0]
  def change
    create_table :spends do |t|
      t.integer :money, null: false
      t.string :comment, null: false

      t.references :user, foreign_key: true, null: false
      t.references :spend_genre, foreign_key: true, null: false

      t.timestamps
    end
  end
end
