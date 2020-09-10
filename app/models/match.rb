class Match < ApplicationRecord
  has_many :players
  has_many :logs

  def write_log(message:, player:)
    logs.create(message: message, player: player)
  end
end
