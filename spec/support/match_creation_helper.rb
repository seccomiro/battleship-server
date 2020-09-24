def create_match(board_height: 10, board_width: 10)
  @match = create(:match)
  create_my_player(board_height: board_height, board_width: board_width)
  create_opponent_player(board_height: board_height, board_width: board_width)
end

def create_my_player(board_height: 10, board_width: 10)
  @my_user = create(:user, email: 'user1@user.com', name: 'User 1')
  @my_player = create(:player, match: @match, user: @my_user)
  @my_player.create_board(height: board_height, width: board_width)
end

def create_opponent_player(board_height: 10, board_width: 10)
  @opponent_user = create(:user, email: 'user2@user.com', name: 'User 2')
  @opponent_player = create(:player, match: @match, user: @opponent_user)
  @opponent_player.create_board(height: board_height, width: board_width)
end
