class RemoveConstraintMatchIdFromPlayers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :players, :match_id, true
  end
end
