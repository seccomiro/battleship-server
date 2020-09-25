class CreateBoats < ActiveRecord::Migration[6.0]
  def change
    create_table :boats do |t|
      t.references :board, null: false, foreign_key: true
      t.integer :size
      t.integer :from_column
      t.integer :to_column
      t.integer :from_row
      t.integer :to_row

      t.timestamps
    end
  end
end
