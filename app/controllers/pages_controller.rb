class PagesController < ApplicationController
  before_action :authenticate_user!
  def timeline
    @following_users = current_user.following
    # display tweets from the users that the current user is following and the current user itself and the tweets that mention the current user in the content
    @activities = PublicActivity::Activity.where(owner_id: @following_users) + PublicActivity::Activity.where(owner_id: current_user) + PublicActivity::Activity.where(recipient_id: current_user)
    @activities.uniq!
    @activities.sort_by!(&:created_at).reverse!
  end
end
