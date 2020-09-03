require 'rails_helper'

RSpec.describe MatchChannel, type: :channel do
  context 'subscribing' do
    it "successfully subscribes" do
      subscribe user_id: 1, match_id: 1
      expect(subscription).to be_confirmed
    end

    it 'tries to subscribe to a match that it is not part of' do
      subscribe user_id: 1, match_id: 2
      expect(subscription).to be_rejected
    end
  end
end
