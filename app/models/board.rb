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

  def place_boat(_boat, from_row:, to_row:, from_column:, to_column:)
    args = { from_row: from_row, to_row: to_row, from_column: from_column, to_column: to_column }

    errors = []
    each_boat_cell(args) do |row, column, value|
      errors << { row: row, column: column, type: :boat_overlapping } if value == :boat
      errors << { row: row, column: column, type: :boat_out_of_bounds } if value == :boat_out_of_bounds
    end
    raise Battleship::BoatPlacingError.new(errors) if errors.any?

    each_boat_cell(args) do |row, column|
      place(row: row, column: column)
    end
  end

  def remove_boat(_boat, from_row:, to_row:, from_column:, to_column:)
    args = { from_row: from_row, to_row: to_row, from_column: from_column, to_column: to_column }
    each_boat_cell(args) do |row, column|
      remove(row: row, column: column)
    end
  end

  private

  def each_boat_cell(from_row:, to_row:, from_column:, to_column:)
    return unless block_given?

    (from_row..to_row).each do |row|
      (from_column..to_column).each do |column|
        value = row < 0 || column < 0 || row >= height || column >= width ? :boat_out_of_bounds : private[row][column]
        yield(row, column, value)
      end
    end
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

  def place(row:, column:)
    cells[row][column] = Board.sym_to_cell_value(:boat)
  end

  def remove(row:, column:)
    cells[row][column] = Board.sym_to_cell_value(:water)
  end
end
