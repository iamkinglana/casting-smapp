class LikesController < ApplicationController

    def create
      cast = Cast.find(params[:cast_id])
      like = cast.likes.build(user: current_user)

      if like.save
        render json: like
      else
        render json: { error: like.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      like = current_user.likes.find(params[:id])
      like.destroy
      render json: { message: 'Like removed successfully' }
    end
  end

end
