require 'rails_helper'

RSpec.describe Player, type: :model do
  context 'with full match previously created' do
    before do
      create_match(distribute_boats: true)
    end

    describe '#opponent' do
      it 'knows its opponent' do
        expect(@my_player.opponent).to eq(@opponent_player)
      end
    end

    describe '#join' do
      it 'can join a match' do
        expect(@my_player.join).to be(true)
      end

      it 'is the first player to join a match' do
        @my_player.join
        expect(@match.players.joined.count).to eq(1)
        expect(@match.players.joined.first).to eq(@my_player)
      end

      it 'is the last player to join a match' do
        @opponent_player.join
        @my_player.join
        expect(@match.players.count).to eq(2)
        expect(@match.players.joined.first).to eq(@opponent_player)
        expect(@match.players.joined.last).to eq(@my_player)
      end
    end

    describe '#full_logs' do
      it 'returns a list of strings with the correct messages' do
        messages = (0..2).map { |i| "Log message #{i}" }
        messages.each { |message| @my_player.logs.build(message: message) }

        messages.each_with_index do |message, i|
          expect(@my_player.full_logs[i]).to eq(message)
        end
      end
    end
  end

  describe '#valid?' do
    context 'when attached to a match' do
      before(:each) do
        create_match
      end

      context 'the board is not mounted' do
        it 'is not valid' do
          expect(@my_player).not_to be_valid
        end
      end

      context 'the board is mounted' do
        it 'is valid' do
          distribute_my_boats

          expect(@my_player).to be_valid
        end
      end
    end

    context 'when not yet attached to a match' do
      before(:each) do
        create_my_player
      end

      it 'is valid' do
        expect(@my_player).to be_valid
      end

      context 'after attaching player to an existing match' do
        before(:each) do
          create_match(players: false)
        end

        context 'the board is mounted' do
          it 'is valid' do
            distribute_my_boats
            @match.attach_player(@my_player)

            expect(@my_player).to be_valid
          end
        end
      end
    end
  end

  describe '#guess' do
    before do
      create_match
    end

    context "when it's the player's turn" do
      before do
        @match.player_playing = @my_player
      end

      context 'at a closed cell' do
        it 'returns a Symbol different from :new' do
          result = @my_player.guess(row: 0, column: 0)

          expect(result).to be_instance_of(Symbol)
          expect(result).not_to eq(:new)
        end
      end

      context 'at a already marked cell' do
        it 'raises a CellNotAllowedError' do
          @my_player.guess(row: 0, column: 0)

          expect { @my_player.guess(row: 0, column: 0) }.to raise_error(Battleship::CellNotAllowedError)
        end
      end
    end

    context "when it's not the player's turn" do
      it 'raises a OtherUserTurnError' do
        expect { @my_player.guess(row: 0, column: 0) }.to raise_error(Battleship::OtherUserTurnError)
      end
    end
  end
end
