Given('I have already created a board with dimensions {int} x {int}') do |width, height|
  create_my_player(board_height: height, board_width: width)
end

When('I ask for the boats to be distributed') do
  @boat_set = @my_player.board.boat_set
end

Then('I should receive the following boats to be distributed: {string}') do |boat_set|
  expect(boat_set.split(',').map(&:to_i)).to match_array(@boat_set)
end
