class AddWinnerToMatches < ActiveRecord::Migration[6.0]
  def change
    add_reference :matches, :winner, null: true, index: true
    add_foreign_key :matches, :players, column: :winner_id
  end
end
