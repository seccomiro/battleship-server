class Match < ApplicationRecord
  has_many :players
  has_many :logs
  enum status: [:created, :has_players, :players_joined, :being_played]
  belongs_to :player_playing, class_name: 'Player', optional: true

  before_save :ensure_status

  def begin
    raise Battleship::MatchStartingError unless players_joined?

    self.started_at = DateTime.now
    self.status = :being_played
    draw_starting_player
    save
  end

  def attach_player(player)
    raise Battleship::PlayerAttachingError unless player.board.mounted?

    players << player
  end

  private

  def draw_starting_player
    self.player_playing = players.sample
  end

  def ensure_status
    self.status = :created unless status
  end
end
