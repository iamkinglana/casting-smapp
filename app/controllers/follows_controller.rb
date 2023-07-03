class FollowsController < ApplicationController

    def create
      followed_user = User.find(params[:followed_user_id])
      follow = current_user.follows.build(followed_user: followed_user)

      if follow.save
        render json: follow
      else
        render json: { error: follow.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      follow = current_user.follows.find(params[:id])
      follow.destroy
      render json: { message: 'Unfollowed successfully' }
    end

end
