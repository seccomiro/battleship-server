class Player < ApplicationRecord
  belongs_to :match
  belongs_to :user, autosave: true
  # has_many :logs, -> { where(logs: { player: self }).or(where(logs: { player: nil })) }, through: :match
  has_many :logs
  scope :joined, -> { where.not(joined_at: nil) }
  delegate :name, :name=, to: :user

  def full_logs
    logs.map(&:to_s)
  end

  def opponent
    match.players.where.not(id: id).first
  end

  def join
    self.joined_at = DateTime.now
    save

    write_log(message: 'Welcome to Battleship')
    case match.players.joined.count
    when 1
      write_log(message: 'Waiting for the other player')
    when 2
      write_log(message: "Your opponent is #{opponent.name}")
      write_log(message: "Your opponent is #{name}", player: opponent)
    end

    true
  end

  def write_log(message:, player: self)
    match.write_log(message: message, player: player)
  end
end
