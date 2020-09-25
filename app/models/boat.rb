class Boat < ApplicationRecord
  belongs_to :board
  scope :docked, -> { where(from_column: nil).or where(to_column: nil).or where(from_row: nil).or where(to_row: nil) }
  scope :placed, -> { where.not(from_column: nil).where.not(to_column: nil).where.not(from_row: nil).where.not(to_row: nil) }

  def docked?
    [from_column, to_column, from_row, to_row].include?(nil)
  end

  def placed?
    !docked?
  end

  def direction
    return if docked?

    return :horizontal if from_column != to_column
    return :vertical if from_row != to_row

    :square
  end

  def place(direction, column:, row:)
    self.from_column = column
    self.from_row = row

    case direction
    when :horizontal
      self.to_column = column + size - 1
      self.to_row = row
    when :vertical
      self.to_column = column
      self.to_row = row + size - 1
    else
      self.to_column = column
      self.to_row = row
    end
    save
    board.place_boat(self)
    true
  end
end
