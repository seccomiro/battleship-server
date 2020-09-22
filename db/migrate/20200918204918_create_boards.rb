class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.references :player, null: false, foreign_key: true
      t.integer :cells, array: true
      t.integer :public_cells, array: true

      t.timestamps
    end
  end
end
