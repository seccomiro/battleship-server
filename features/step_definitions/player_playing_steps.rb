def create_match
  @match = create(:match)
  create_my_player
  create_opponent_player
end

def create_my_player
  @my_user = create(:user, email: 'user1@user.com', name: 'User 1')
  @my_player = create(:player, match: @match, user: @my_user)
end

def create_opponent_player
  @opponent_user = create(:user, email: 'user2@user.com', name: 'User 2')
  @opponent_player = create(:player, match: @match, user: @opponent_user)
end

Given('a match already exists') do
  create_match
end

Given('I am a player named {string}') do |string|
  @my_player.name = string
  @my_player.save
end

Given('my opponent is a player named {string}') do |string|
  @opponent_player.name = string
  @opponent_player.save
end

Given('two players are already attached to the match') do
end

Given('the match is ready to be played by the players') do
end

Given('I am not yet playing') do
end

When('I enter a match') do
  @confirmed = @my_player.join
end

Then('I should know that my sign in is confirmed') do
  expect(@confirmed).to be true
  expect(@my_player.joined_at).not_to be_nil
end

Then('I should see {string}') do |string|
  expect(@my_player.full_logs).to include(string)
end

When('my opponent should see {string}') do |string|
  expect(@opponent_player.full_logs).to include(string)
end

Given('no players have joined a match yet') do
  expect(@match.players.joined.count).to eq(0)
end

Given('another player have already joined a match') do
  @opponent_player.join
  expect(@match.players.joined.count).to eq(1)
end
