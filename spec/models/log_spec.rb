require 'rails_helper'

RSpec.describe Log, type: :model do
  before(:each) do
    create_match
  end

  describe '.create' do
    context 'for himself' do
      it 'logs a message' do
        @my_player.logs.create(message: 'Log message')
        logs = @my_player.logs.map(&:message)

        expect(logs.count).to eq(1)
        expect(logs).to include('Log message')
      end

      it 'logs several messages in order' do
        messages = (0..2).map { |i| "Log message #{i}" }
        messages.each { |message| @my_player.logs.create(message: message) }

        expect(@my_player.logs.count).to eq(3)
        messages.each_with_index do |message, i|
          expect(@my_player.logs[i].message).to eq(message)
        end
      end
    end

    context 'for the opponent' do
      it 'logs a message' do
        @my_player.opponent.logs.create(message: 'Log message')
        logs = @my_player.opponent.logs.map(&:message)

        expect(logs.count).to eq(1)
        expect(logs).to include('Log message')
      end
    end
  end

  describe '#to_s' do
    it 'returns the right string value' do
      log = build(:log)

      expect(log.to_s).to eq(log.message)
    end
  end
end
