class CastsController < ApplicationController

    def index
      casts = Cast.all
      render json: casts
    end

    def create
      cast = current_user.casts.build(cast_params)
      if cast.save
        render json: cast
      else
        render json: { error: cast.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def show
      cast = Cast.find(params[:id])

      cast_data = {
        id: cast.id,
        content: cast.content,
        author: cast.user.username,
        timestamp: cast.created_at,
        likes: cast.likes&.count || 0,
        comments: cast.comments&.count || 0
      }

      render json: cast_data

    end

    def update
      cast = current_user.casts.find(params[:id])
      if cast.update(cast_params)
        render json: { message: 'Cast updated successfully' }
      else
        render json: { error: cast.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      cast = current_user.casts.find(params[:id])
      cast.destroy
      render json: { message: 'Cast deleted successfully' }
    end

    private

    def cast_params
      params.permit(:content)
    end


end
