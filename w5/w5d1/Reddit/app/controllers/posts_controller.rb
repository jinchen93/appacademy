class PostsController < ApplicationController
  before_filter :ensure_author, only: [:edit, :update]
  helper_method :author?

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to sub_url(@post.subs.first.title)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    render :show
  end

  def edit
    render :edit
  end

  def update
    if @post.update_attributes(post_params)
      redirect_to sub_url(@post.subs.first.title)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  private
  def post_params
    params.require(:post).permit(
      :title,
      :url,
      :content,
      sub_ids: []
    )
  end

  def ensure_author
    @post = Post.find(params[:id])
    author?
  end

  def author?
    current_user == @post.author
  end
end
