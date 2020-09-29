class Match < ApplicationRecord
  has_many :players
  has_many :logs
  enum status: [:created, :ready, :players_joined, :being_played]
  belongs_to :player_playing, class_name: 'Player', optional: true

  before_save :ensure_status

  def begin
    raise Battleship::MatchStartingError.new unless players_joined?

    self.started_at = DateTime.now
    self.status = :being_played
    save
  end

  private

  def ensure_status
    self.status = :created unless status
  end
end
