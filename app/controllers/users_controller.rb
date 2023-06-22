class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followers, :following]

  def index
    # params[:type] = "followers" or "following"
    if params[:type] == "followers"
      @users = current_user.followers.order(created_at: :desc)
    elsif params[:type] == "following"
      @users = current_user.following.order(created_at: :desc)
    else
      @users = User.all.order(created_at: :desc)
    end
  end

  def show
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
