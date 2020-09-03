Given('a match already exists') do
  @match = create(:match)
end

Given('two players are already attached to the match') do
  @user1 = create(:user, email: 'user1@user.com')
  @user2 = create(:user, email: 'user2@user.com')
  @player1 = create(:player, match: @match, user: @user1)
  @player2 = create(:player, match: @match, user: @user2)
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
  expect(@match.logs.last.message).to eq(string)
end
