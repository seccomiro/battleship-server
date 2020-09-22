require 'rails_helper'

RSpec.describe Player, type: :model do
  before(:each) do
    create_match
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
