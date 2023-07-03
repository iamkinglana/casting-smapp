class CommentsController < ApplicationController
     def create
      cast = Cast.find(params[:cast_id])
      comment = cast.comments.build(comment_params)
      comment.user = current_user

      if comment.save
        render json: comment
      else
        render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      comment = current_user.comments.find(params[:id])
      if comment.update(comment_params)
        render json: { message: 'Comment updated successfully' }
      else
        render json: { error: comment.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      comment = current_user.comments.find(params[:id])
      comment.destroy
      render json: { message: 'Comment deleted successfully' }
    end

    private

    def comment_params
      params.permit(:content)
    end

end
