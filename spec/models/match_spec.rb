require 'rails_helper'

RSpec.describe Match, type: :model do
  before(:each) do
    create_match
  end

  describe '#joined' do
    context 'when the first enrolled player joins first' do
      it 'return the players in the right order' do
        @my_player.join
        @opponent_player.join
        expect(@match.players.joined.first).to eq(@my_player)
        expect(@match.players.joined.last).to eq(@opponent_player)
      end
    end

    context 'when the first enrolled player joins last' do
      it 'return the players in the right order' do
        @opponent_player.join
        @my_player.join
        expect(@match.players.joined.first).to eq(@opponent_player)
        expect(@match.players.joined.last).to eq(@my_player)
      end
    end
  end
end
