class Log < ApplicationRecord
  belongs_to :match
  belongs_to :player, optional: true

  before_validation :ensure_data

  def to_s
    message
  end

  private

  def ensure_data
    self.match = player.match unless match
  end
end
