class Match < ApplicationRecord
  has_many :players
  has_many :logs
  enum status: [:created, :ready]
  belongs_to :player_playing, class_name: 'Player', optional: true

  before_save :ensure_status

  private

  def ensure_status
    self.status = :created unless status
  end
end
