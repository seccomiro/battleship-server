require 'rails_helper'

RSpec.describe Match, type: :model do
  context 'with full match previously created' do
    before(:each) do
      create_match(distribute_boats: true)
    end

    it { is_expected.to define_enum_for(:status).with([:created, :has_players, :players_joined, :being_played, :finished]) }

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
      context 'when the players have already joined the match and it can begin' do
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

  describe '#attach_player' do
    it 'responds' do
      expect(subject).to respond_to(:attach_player)
    end

    it 'pushed the player into players array' do
      create_my_player(distribute_boats: true)
      create_match(players: false)

      @match.attach_player(@my_player)

      expect(@match.players).to include(@my_player)
    end

    context 'when the board is not mounted' do
      it 'raises a PlayerAttachingError' do
        create_my_player
        create_match(players: false)

        expect { @match.attach_player(@my_player) }.to raise_error(Battleship::PlayerAttachingError)
      end
    end
  end
end
