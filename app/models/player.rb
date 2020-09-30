class Player < ApplicationRecord
  belongs_to :match, autosave: true, optional: true
  belongs_to :user, autosave: true
  # has_many :logs, -> { where(logs: { player: self }).or(where(logs: { player: nil })) }, through: :match
  has_many :logs
  has_one :board
  scope :joined, -> { where.not(joined_at: nil).order(:joined_at) }
  delegate :name, :name=, to: :user
  validate :board_is_fully_mounted, unless: -> { match.nil? || board.nil? }

  after_create :set_match_status

  def full_logs
    logs.map(&:to_s)
  end

  def opponent
    return unless match

    match.players.where.not(id: id).first
  end

  def join
    return unless match

    self.joined_at = DateTime.now
    save

    logs.create(message: 'Welcome to Battleship')
    case match.players.joined.count
    when 1
      logs.create(message: 'Waiting for the other player')
    when 2
      logs.create(message: "Your opponent is #{opponent.name}")
      opponent.logs.create(message: "Your opponent is #{name}")
      match.status = :players_joined
      match.save
    end

    true
  end

  def playing?
    match&.player_playing == self
  end

  def guess(row:, column:)
    opponent.board.mark(row: row, column: column)
  end

  private

  def set_match_status
    return unless match

    match.status = :ready if match.players.count == 2
    match.save
  end

  def board_is_fully_mounted
    errors.add(:board, 'is not fully mounted') unless board.mounted?
  end
end
