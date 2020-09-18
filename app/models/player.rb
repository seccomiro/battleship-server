class Player < ApplicationRecord
  belongs_to :match, autosave: true
  belongs_to :user, autosave: true
  # has_many :logs, -> { where(logs: { player: self }).or(where(logs: { player: nil })) }, through: :match
  has_many :logs
  has_one :board
  scope :joined, -> { where.not(joined_at: nil).order(:joined_at) }
  delegate :name, :name=, to: :user

  after_create :set_match_status

  def full_logs
    logs.map(&:to_s)
  end

  def opponent
    match.players.where.not(id: id).first
  end

  def join
    self.joined_at = DateTime.now
    save

    logs.create(message: 'Welcome to Battleship')
    case match.players.joined.count
    when 1
      logs.create(message: 'Waiting for the other player')
    when 2
      logs.create(message: "Your opponent is #{opponent.name}")
      opponent.logs.create(message: "Your opponent is #{name}")
    end

    true
  end

  private

  def set_match_status
    match.status = :ready if match.players.count == 2
    match.save
  end
end
