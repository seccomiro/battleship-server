class Player < ApplicationRecord
  belongs_to :match
  belongs_to :user
  has_many :logs, -> { where(logs: { player: self }).or.where(logs: { player: nil }) }, through: :match
end
