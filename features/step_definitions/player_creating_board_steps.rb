Given('I am a registered user') do
  create_my_user
end

Given('I have no staging board') do
  expect(@my_user.boards.staging.count).to eq(0)
end

When('I ask to create a new board with dimensions {int} x {int}') do |width, height|
  @my_player = create(:player, user: @my_user)
  @my_board = @my_player.create_board(height: height, width: width)
end

Then('I should receive an empty board with dimensions {int} x {int}') do |width, height|
  expect(@my_board.height).to eq(height)
  expect(@my_board.width).to eq(width)
  expect(@my_board.empty?).to be(true)
end
