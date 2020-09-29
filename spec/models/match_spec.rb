require 'rails_helper'

RSpec.describe Match, type: :model do
  before(:each) do
    create_match
  end

  it { is_expected.to define_enum_for(:status).with([:created, :ready, :players_joined, :being_played]) }

  describe '#players.joined' do
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

  describe '#begin' do
    context 'when the players have already joined the match and are ready to be played' do
      it 'starts the match and return true' do
        @opponent_player.join
        @my_player.join

        expect(@match.begin).to be(true)
        expect(@match.started_at).to be <= DateTime.now
      end
    end

    context 'when the players did not join or are not waiting to start playing the match' do
      it 'raises a MatchStartingError' do
        expect { @match.begin }.to raise_error(Battleship::MatchStartingError)
      end
    end
  end
end
