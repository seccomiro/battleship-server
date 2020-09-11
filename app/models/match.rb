class Match < ApplicationRecord
  has_many :players
  has_many :logs
  enum status: [:created, :ready]

  before_save :ensure_status

  private

  def ensure_status
    self.status = :created unless status
  end
end
