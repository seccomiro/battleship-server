def create_match
  @match = create(:match)
end

def create_player1
  @user1 = create(:user, email: 'user1@user.com')
  @player1 = create(:player, match: @match, user: @user1)
end

def create_player2
  @user2 = create(:user, email: 'user2@user.com')
  @player2 = create(:player, match: @match, user: @user2)
end

Given('a match already exists') do
  create_match
end

Given('two players are already attached to the match') do
  create_player1
  create_player2
end

Given('the match is ready to be played by the players') do
end

Given('I am not yet playing') do
end

When('I enter a match') do
  @confirmed = @match.join(@player1)
end

Then('I should know that my sign in is confirmed') do
  expect(@confirmed).to be true
  expect(@player1.joined_at).not_to be_nil
end

Then('I should see {string}') do |string|
  expect(@player1.full_logs).to include(string)
end

Given('I entered a match') do
  create_player1
  @match.join(@player1)
end

When('I am the first player to enter the match') do
  expect(@match.players.count).to eq(1)
end
