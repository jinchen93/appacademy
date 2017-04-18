class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render(
        json: comment.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end

  def index
    # will render based on user param or artwork param
    # /comments?author_id=1
    if params[:author_id]
      comments = Comment.where(author_id: params[:author_id])
    elsif params[:artwork_id]
      comments = Comment.where(artwork_id: params[:artwork_id])
    end
    render json: comments
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :artwork_id, :author_id)
  end
end
