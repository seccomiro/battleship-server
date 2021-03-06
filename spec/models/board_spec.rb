require 'rails_helper'

RSpec.describe Board, type: :model do
  describe '.generate' do
    it 'returns an Array' do
      expect(Board.generate).to be_instance_of(Array)
    end

    it 'returns a a matrix' do
      expect(Board.generate[0]).to be_instance_of(Array)
    end

    it 'has valid Symbols at all positions' do
      expect(Board.generate(height: 2, width: 2)).to match_array([[:water, :water], [:water, :water]])
    end

    context 'with no arguments' do
      it 'returns a matrix with default (10x10) size' do
        cells = Board.generate

        expect(cells.size).to be(10)
        expect(cells[0].size).to be(10)
      end
    end

    context 'only with height argument' do
      it 'returns a matrix with default (10) width and defined height' do
        cells = Board.generate(height: 5)

        expect(cells.size).to be(5)
        expect(cells[0].size).to be(10)
      end
    end

    context 'only with width argument' do
      it 'returns a matrix with default (10) height and defined width' do
        cells = Board.generate(width: 5)

        expect(cells.size).to be(10)
        expect(cells[0].size).to be(5)
      end
    end

    context 'with height and width arguments defined' do
      it 'returns a matrix with height and width equals to arguments' do
        cells = Board.generate(height: 3, width: 5)

        expect(cells.size).to be(3)
        expect(cells[0].size).to be(5)
      end
    end
  end

  describe '.create' do
    it 'ensures the creation of the public board' do
      create_match

      expect(@my_player.board.public).not_to be_nil
    end

    it 'ensures the public board is based on the private board' do
      create_match
      board = @my_player.board

      expect(board.public.size).to eq(board.height)
      expect(board.public[0].size).to eq(board.width)
    end

    it 'ensures the creation of the boats' do
      create_my_player

      expect(@my_player.board.boats.count).to be > 0
    end
  end

  describe '#public' do
    it 'exists' do
      expect(subject).to respond_to(:public)
    end

    it 'returns a board with the same size of the private board' do
      create_match(board_height: 2, board_width: 2)
      board = @my_player.board

      expect(board.public.size).to eq(board.private.size)
      expect(board.public[0].size).to eq(board.private[0].size)
    end

    context 'when not yet played' do
      it 'returns a board only with :new Symbols' do
        create_match(board_height: 2, board_width: 2)
        board = @my_player.board

        expect(board.public).to match_array([[:new, :new], [:new, :new]])
      end
    end
  end

  describe '#private' do
    it 'exists' do
      expect(subject).to respond_to(:private)
    end

    context 'with an empty board' do
      it 'returns a board only with :water Symbols' do
        create_match(board_height: 2, board_width: 2)
        board = @my_player.board

        expect(board.private).to match_array([[:water, :water], [:water, :water]])
      end
    end
  end

  describe 'getting dimensions' do
    before do
      create_match(board_height: 5, board_width: 3)
    end

    let(:board) { @my_player.board }

    describe '#height' do
      it 'returns the height of the board' do
        expect(board.height).to eq(board.private.size)
      end
    end

    describe '#width' do
      it 'returns the width of the board' do
        expect(board.width).to eq(board.private[0].size)
      end
    end
  end

  describe '#new?' do
    context 'match not yet played' do
      it 'returns "true"' do
        create_match

        expect(@my_player.board.new?).to be(true)
      end
    end
  end

  describe '#mark' do
    before do
      create_match
    end

    context 'at a closed cell' do
      it 'returns a Symbol different from :new' do
        result = @my_player.board.mark(row: 0, column: 0)

        expect(result).to be_instance_of(Symbol)
        expect(result).not_to eq(:new)
      end
    end

    context 'at a already marked cell' do
      it 'raises a CellNotAllowedError' do
        @my_player.board.mark(row: 0, column: 0)

        expect { @my_player.board.mark(row: 0, column: 0) }.to raise_error(Battleship::CellNotAllowedError)
      end
    end
  end

  describe '.cell_value_to_sym' do
    it 'always returns the right value' do
      expect(Board.cell_value_to_sym(nil)).to eq(:new)
      expect(Board.cell_value_to_sym(1)).to eq(:boat)
      expect(Board.cell_value_to_sym(2)).to eq(:water)
    end
  end

  describe '.sym_to_cell_value' do
    it 'always returns the right value' do
      expect(Board.sym_to_cell_value(:boat)).to eq(1)
      expect(Board.sym_to_cell_value(:water)).to eq(2)
    end
  end

  describe '.staging' do
    context 'with no staging boards' do
      it 'returns 0' do
        create_my_user

        expect(@my_user.boards.staging.count).to eq(0)
      end
    end

    context 'with staging boards' do
      it 'returns 1' do
        create_my_player

        expect(@my_user.boards.staging.count).to eq(1)
      end
    end
  end

  describe '#empty?' do
    before do
      create_my_player
    end
    let(:all_water) { @my_player.board.private.all? { |row| row.all? { |cell| cell == :water } } }

    it 'returns true if all the positions of the private board have :water' do
      expect(all_water).to be(true)
    end

    it 'returns false if any of the positions of the private board have :water' do
      @my_player.board.cells[0][0] = Board.sym_to_cell_value(:boat)

      expect(all_water).to be(false)
    end
  end

  describe '#board.boats' do
    let(:boat_set) { @my_player.board.boats.order(size: :desc).pluck(:size) }

    context 'with a 5x5 board' do
      it 'returns an array "[3, 2, 1]"' do
        create_my_player(board_height: 5, board_width: 5)

        expect(boat_set).to match_array([3, 2, 1])
      end
    end

    context 'with a 10x10 board' do
      it 'returns an array "[5, 4, 3, 3, 2]"' do
        create_my_player(board_height: 10, board_width: 10)

        expect(boat_set).to match_array([5, 4, 3, 3, 2])
      end
    end

    context 'with a 15x15 board' do
      it 'returns an array "[8, 7, 6, 5, 4, 4, 3, 2]"' do
        create_my_player(board_height: 15, board_width: 15)

        expect(boat_set).to match_array([8, 7, 6, 5, 4, 4, 3, 2])
      end
    end

    context 'with an invalid board size board' do
      it 'returns an empty Array' do
        create_my_player(board_height: 7, board_width: 18)

        expect(boat_set).to match_array([])
      end
    end
  end

  describe '#place_boat' do
    context 'placing boat in vertical' do
      it 'places the boat in the board' do
        create_my_player(board_height: 2, board_width: 2)

        boat = create(:boat, board: @my_player.board, size: 2)
        @my_player.board.place_boat(boat, from_row: 0, to_row: 1, from_column: 0, to_column: 0)

        expect(@my_player.board.private).to match_array([[:boat, :water], [:boat, :water]])
      end
    end

    context 'placing boat in horizontal' do
      it 'places the boat in the board' do
        create_my_player(board_height: 2, board_width: 2)

        boat = create(:boat, board: @my_player.board, size: 2)
        @my_player.board.place_boat(boat, from_row: 0, to_row: 0, from_column: 0, to_column: 1)

        expect(@my_player.board.private).to match_array([[:boat, :boat], [:water, :water]])
      end
    end
  end

  describe '#remove_boat' do
    it 'removes the boat from the board' do
      create_my_player(board_height: 2, board_width: 2)
      boat = create(:boat, board: @my_player.board, size: 2)
      boat.place(:vertical, column: 0, row: 0)

      @my_player.board.remove_boat(boat, from_row: 0, to_row: 1, from_column: 0, to_column: 0)

      expect(@my_player.board.private).to match_array([[:water, :water], [:water, :water]])
    end
  end

  describe '#mounted?' do
    before do
      create_match
      distribute_my_boats
    end

    context 'when all the boats are placed' do
      it 'returns true' do
        expect(@my_player.board.mounted?).to be(true)
      end
    end

    context 'when at least one boat is not placed' do
      it 'returns false' do
        @my_player.board.boats.placed.last.remove

        expect(@my_player.board.mounted?).to be(false)
      end
    end
  end

  describe '#hit_count' do
    it 'returns the number of boats hit' do
      board = build(:board)

      board.private = [[:boat, :boat], [:water, :water]]
      board.public_cells = [[nil, nil], [nil, nil]]
      board.mark(row: 0, column: 0)
      board.mark(row: 0, column: 1)
      board.mark(row: 1, column: 0)

      expect(board.hit_count).to eq(2)
    end
  end

  describe '#boat_cell_count' do
    it 'returns the count of cells with boats on the private board' do
      board = build(:board)

      board.private = [[:boat, :boat], [:water, :boat]]

      expect(board.boat_cell_count).to eq(3)
    end
  end

  describe '#all_boats_hit' do
    let(:board) { build(:board) }
    before do
      board.private = [[:boat, :boat], [:water, :water]]
      board.public_cells = [[nil, nil], [nil, nil]]
      board.mark(row: 0, column: 0)
    end

    context 'when all the boats were hit' do
      it 'returns true' do
        board.mark(row: 0, column: 1)

        expect(board.all_boats_hit?).to be(true)
      end
    end

    context 'when not all the boats were hit' do
      it 'returns true' do
        board.mark(row: 1, column: 1)

        expect(board.all_boats_hit?).to be(false)
      end
    end
  end
end
