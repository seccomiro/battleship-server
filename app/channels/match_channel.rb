class MatchChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:user_id] == 1
    reject unless params[:match_id] == 1
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
