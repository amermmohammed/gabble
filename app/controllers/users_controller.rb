class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followers, :following]
  before_action :authenticate_user!, only: [:index]

  def index
    # params[:type] = "followers" or "following"
    if params[:type] == "followers"
      @users = current_user.followers.order(created_at: :desc)
    elsif params[:type] == "following"
      @users = current_user.following.order(created_at: :desc)
    else
      @users = User.all.order(created_at: :desc)
    end

    respond_to do |format|
      format.html
      format.json {
        render :json => User.mentions(params[:q])
      }
    end
  end

  def show
    # create a new tweet for the user
    @tweet = Tweet.new
    # get all tweets of the user
    @tweets = @user.retweets + @user.tweets
    @tweets.sort_by!(&:created_at).reverse!
    # Get all activities of the user
    @activities = PublicActivity::Activity.where(owner: @user) + PublicActivity::Activity.where(recipient: @user)
    @activities.uniq!
    @activities.sort_by!(&:created_at).reverse!
  end

  def followers
    @users = @user.followers.order(created_at: :desc)
  end

  def following
    @users = @user.following.order(created_at: :desc)
  end

  private
  def set_user
    @user = User.find_by_username(params[:id])
  end
end
