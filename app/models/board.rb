class Board < ApplicationRecord
  belongs_to :player

  before_create :ensure_public_board

  def public
    options = { nil => :new, 1 => :hit, 2 => :miss }
    public_cells.map { |row| row.map { |cell| options[cell] } }
  end

  def new?
    public.all? { |row| row.all? { |cell| cell == :new } }
  end

  def self.generate(height: 10, width: 10)
    [[nil] * width] * height
  end

  def height
    cells.size
  end

  def width
    cells[0].size
  end

  private

  def ensure_public_board
    self.public_cells = cells.map do |row|
      row.map do
        nil
      end
    end
  end
end
