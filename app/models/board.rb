class Board < ApplicationRecord
  belongs_to :player
  scope :staging, -> { where(players: { match: nil }) }
  has_many :boats

  before_create :ensure_public_board
  before_create :ensure_boats

  def initialize(arguments)
    height = 10
    width = 10
    if arguments&.key?(:height)
      height = arguments[:height]
      arguments.delete(:height)
    end
    if arguments&.key?(:width)
      width = arguments[:width]
      arguments.delete(:width)
    end

    super(arguments)

    self.private = Board.generate(height: height, width: width)
  end

  def public
    public_cells.map { |row| row.map { |cell| Board.cell_value_to_sym(cell) } }
  end

  def private
    cells.map { |row| row.map { |cell| Board.cell_value_to_sym(cell) } }
  end

  def private=(value)
    self.cells = value.map { |row| row.map { |cell| Board.sym_to_cell_value(cell) } }
  end

  def new?
    public.all? { |row| row.all? { |cell| cell == :new } }
  end

  def empty?
    private.all? { |row| row.all? { |cell| cell == :water } }
  end

  def self.generate(height: 10, width: 10)
    [[:water] * width] * height
  end

  def height
    cells.size
  end

  def width
    cells[0].size
  end

  def mark(row:, column:)
    public_cells[row][column] = cells[row][column]
    save
    Board.cell_value_to_sym(public_cells[row][column])
  end

  def self.cell_value_to_sym(value)
    options = { nil => :new, 1 => :boat, 2 => :water }
    options[value]
  end

  def self.sym_to_cell_value(symbol)
    options = { boat: 1, water: 2 }
    options[symbol]
  end

  def boat_set
    if width == 5 && height == 5
      [3, 2, 1]
    elsif width == 10 && height == 10
      [5, 4, 3, 3, 2]
    elsif width == 15 && height == 15
      [8, 7, 6, 5, 4, 4, 3, 2]
    end
  end

  private

  def ensure_public_board
    self.public_cells = cells.map do |row|
      row.map do
        nil
      end
    end
  end

  def ensure_boats
    return unless boat_set

    boat_set.each do |size|
      boats.build(size: size)
    end
  end
end
