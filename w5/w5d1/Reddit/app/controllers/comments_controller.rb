class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
    render :new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post_id)
    end
  end

  def show
    @comment = Comment.find(params[:id])
    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(
      :content,
      :post_id,
      :parent_comment_id
    )
  end
end
