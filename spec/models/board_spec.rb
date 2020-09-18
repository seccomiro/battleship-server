require 'rails_helper'

RSpec.describe Board, type: :model do
  describe '.generate' do
    it 'returns an Array' do
      expect(Board.generate).to be_instance_of(Array)
    end

    it 'the returned Array is a matrix' do
      expect(Board.generate[0]).to be_instance_of(Array)
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
  end

  describe '#public' do
    it 'exists' do
      expect(subject).to respond_to(:public)
    end

    it 'returns a board with the same size of the private board' do
      create_match
      board = @my_player.board

      expect(board.public.size).to eq(board.cells.size)
      expect(board.public[0].size).to eq(board.cells[0].size)
    end
  end

  describe 'getting dimensions' do
    before do
      create_match(board_height: 5, board_width: 3)
    end

    let(:board) { @my_player.board }

    describe '#height' do
      it 'returns the height of the board' do
        expect(board.height).to eq(board.cells.size)
      end
    end

    describe '#width' do
      it 'returns the width of the board' do
        expect(board.width).to eq(board.cells[0].size)
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
end
