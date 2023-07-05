class FollowsController < ApplicationController
  def create
    followed_user = User.find(params[:followed_user_id])
    follow = current_user.follows.build(followed_user: followed_user)

    if follow.save
      update_follower_counts(followed_user)
      render json: follow
    else
      render json: { error: follow.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    follow = current_user.follows.find(params[:id])
    followed_user = follow.followed_user
    follow.destroy
    update_follower_counts(followed_user)
    render json: { message: 'Unfollowed successfully' }
  end

  private

  
  def update_follower_counts(user)
    user.update(followers_count: user.followers.count)
    current_user.update(following_count: current_user.following.count)
  end
end
