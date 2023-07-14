class RetweetsController < ApplicationController
  before_action :authenticate_user!
  def create
    retweet = current_user.retweets.new(origin_tweet_id: params[:tweet_id])
    if retweet.save
      retweet.create_activity key: "retweet.created", owner: current_user, recipient: retweet.origin_tweet.user
      redirect_to user_path(current_user.username), notice: "Retweeted!"
    else
      redirect_back fallback_location: root_path, alert: "Retweet failed!"
    end
  end

  def destroy
    retweet = current_user.retweets.find(params[:id])
    retweet.destroy
    redirect_to user_path(current_user.username), notice: "Retweet removed!"
  end

end
