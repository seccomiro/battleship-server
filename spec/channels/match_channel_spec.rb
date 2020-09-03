require 'rails_helper'

RSpec.describe MatchChannel, type: :channel do
  # let(:user1) { create(:user, email: 'user1@user.com') }
  # let(:user2) { create(:user, email: 'user2@user.com') }
  # let(:match) { create(:match) }
  # let(:player1) { create(:player, match: match, user: user1) }
  # let(:player2) { create(:player, match: match, user: user2) }

  before(:all) do
    @user1 = create(:user, email: 'user1@user.com')
    @user2 = create(:user, email: 'user2@user.com')
    @match = create(:match)
    @player1 = create(:player, match: @match, user: @user1)
    @player2 = create(:player, match: @match, user: @user2)

    stub_connection
  end

  context 'subscribing' do
    it "successfully subscribes to a match" do
      subscribe user_id: @user1.id, match_id: @match.id
      expect(subscription).to be_confirmed
    end

    it 'tries to subscribe to a match that it is not part of' do
      another_match = create(:match)

      subscribe user_id: @user1.id, match_id: another_match.id
      expect(subscription).to be_rejected
    end
  end
end
