class Log < ApplicationRecord
  belongs_to :match
  belongs_to :player, optional: true

  def to_s
    message
  end
end
