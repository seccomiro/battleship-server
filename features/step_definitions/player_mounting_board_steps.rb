Given('I have a board with dimensions {int} x {int}') do |width, height|
  create_my_player(board_height: height, board_width: width)
end

Given('I have a set of boats for that board') do
  @boats = @my_player.board.boats
end

When('I place each boat side by side from the biggest to the smallest, beginning from the top-left') do
  @boats.order(size: :desc).each_with_index do |boat, i|
    boat.place(:vertical, column: i, row: 0)
  end
end

Then('my private board should be: {string}') do |matrix_string|
  matrix = matrix_string.split('/').map { |row| row.split(',').map(&:to_sym) }

  expect(@my_player.board.private).to match_array(matrix)
end

Then('there should be no boats left') do
  expect(@my_player.board.boats.docked.count).to eq(0)
end
