class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_likeable
  before_action :destroy_likeable_activity

  def create
    @likeable.liked_by current_user
    @likeable.create_activity key: "tweet.liked", owner: current_user, recipient: @likeable.user
    render "update_likes_and_dislikes"
  end

  def destroy
    @likeable.disliked_by current_user
    @likeable.create_activity key: "tweet.disliked", owner: current_user, recipient: @likeable.user
    render "update_likes_and_dislikes"
  end

  private

  def find_likeable
    @likeable_type = params[:likeable_type].classify # "tweet" => "Tweet" # "comment" => "Comment" # "reply" => "Reply" # "post" => "Post"
    @likeable = @likeable_type.constantize.find(params[:likeable_id]) # Tweet.find(params[:tweet_id]) # Comment.find(params[:comment_id]) # Reply.find(params[:reply_id]) # Post.find(params[:post_id])
  end

  def destroy_likeable_activity
    @likeable.activities.where(owner: current_user, key: "tweet.liked").first&.destroy
    @likeable.activities.where(owner: current_user, key: "tweet.disliked").first&.destroy
  end

end
