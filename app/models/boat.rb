class Boat < ApplicationRecord
  belongs_to :board, autosave: true
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
    from_column = column
    from_row = row

    case direction
    when :horizontal
      to_column = column + size - 1
      to_row = row
    when :vertical
      to_column = column
      to_row = row + size - 1
    else
      to_column = column
      to_row = row
    end

    board.place_boat(self, from_row: from_row, to_row: to_row, from_column: from_column, to_column: to_column)

    self.from_row = from_row
    self.to_row = to_row
    self.from_column = from_column
    self.to_column = to_column

    save
    true
  end
end
