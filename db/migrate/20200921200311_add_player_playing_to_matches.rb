class AddPlayerPlayingToMatches < ActiveRecord::Migration[6.0]
  def change
    add_reference :matches, :player_playing, null: true, index: true
    add_foreign_key :matches, :players, column: :player_playing_id
  end
end
