class Match < ApplicationRecord
  has_many :players
  has_many :logs

  def join(player)
    player.joined_at = DateTime.now
    player.save
    write_log(message: 'Welcome to Battleship', player: player)
    write_log(message: 'Waiting for the other player', player: player) if players.count == 1
    true
  end

  private

  def write_log(message:, player: nil)
    logs.create(message: message, player: player)
  end
end
