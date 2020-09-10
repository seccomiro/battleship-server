class AddJoinedAtToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :joined_at, :datetime
  end
end
