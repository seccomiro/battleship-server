require 'rails_helper'

RSpec.describe Boat, type: :model do
  before do
    create_my_player(board_height: 5, board_width: 5)
  end
  let(:first_boat) { @my_player.board.boats.first }

  describe '#place' do
    it 'places the boat and return true' do
      expect(first_boat.place(:vertical, column: 0, row: 0)).to be(true)
    end
  end

  describe '#docked?' do
    context 'the boat is docked' do
      it 'returns true' do
        expect(first_boat.docked?).to be(true)
      end
    end

    context 'the boat is placed' do
      it 'returns false' do
        first_boat.place(:vertical, column: 0, row: 0)

        expect(first_boat.docked?).to be(false)
      end
    end
  end

  describe '#placed?' do
    context 'the boat is docked' do
      it 'returns false' do
        expect(first_boat.placed?).to be(false)
      end
    end

    context 'the boat is placed' do
      it 'returns true' do
        first_boat.place(:vertical, column: 0, row: 0)

        expect(first_boat.placed?).to be(true)
      end
    end
  end

  describe '#direction' do
    context 'the boat is placed in vertical' do
      it 'returns :vertical' do
        boat = create(:boat, board: @my_player.board, size: 2)
        boat.place(:vertical, column: 0, row: 0)

        expect(boat.direction).to eq(:vertical)
      end
    end

    context 'the boat is placed in horizontal' do
      it 'returns :horizontal' do
        boat = create(:boat, board: @my_player.board, size: 2)
        boat.place(:horizontal, column: 0, row: 0)

        expect(boat.direction).to eq(:horizontal)
      end
    end

    context 'the boat has dimensions 1x1' do
      it 'returns :square' do
        boat = create(:boat, board: @my_player.board, size: 2)
        boat.place(:square, column: 0, row: 0)

        expect(boat.direction).to eq(:square)
      end
    end
  end

  describe '.docked' do
    it 'returns the right number of docked boats' do
      count = @my_player.board.boats.count

      expect(@my_player.board.boats.docked.count).to eq(count)

      @my_player.board.boats[0].place(:vertical, column: 0, row: 0)
      expect(@my_player.board.boats.docked.count).to eq(count - 1)

      @my_player.board.boats[1].place(:vertical, column: 1, row: 1)
      expect(@my_player.board.boats.docked.count).to eq(count - 2)
    end
  end

  describe '.placed' do
    it 'returns the right number of placed boats' do
      expect(@my_player.board.boats.placed.count).to eq(0)

      @my_player.board.boats[0].place(:vertical, column: 0, row: 0)
      expect(@my_player.board.boats.placed.count).to eq(1)

      @my_player.board.boats[1].place(:vertical, column: 1, row: 1)
      expect(@my_player.board.boats.placed.count).to eq(2)
    end
  end
end
