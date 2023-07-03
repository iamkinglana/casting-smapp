class LikesController < ApplicationController

    def create
      cast = Cast.find(params[:cast_id])
      like = cast.likes.find_by(user: current_user)

      if like
        render json: { error: 'User has already liked this cast' }, status: :unprocessable_entity
      else
        like = cast.likes.build(user: current_user)

        if like.save
          cast.update(likes: cast.likes + 1) # Increment likes count
          render json: like
        else
          render json: { error: like.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end

    def destroy
      like = current_user.likes.find(params[:id])
      cast = like.cast

      like.destroy
      cast.update(likes: cast.likes - 1) # Decrement likes count

      render json: { message: 'Like removed successfully' }
    end

end
