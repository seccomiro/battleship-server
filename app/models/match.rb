class Match < ApplicationRecord
  has_many :players
  has_many :logs
  enum status: [:created, :ready]

  before_save :ensure_status

  def write_log(message:, player:)
    logs.create(message: message, player: player)
  end

  def ensure_status
    self.status = :created unless status
  end
end
