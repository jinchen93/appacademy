class PostsController < ApplicationController
  before_filter :ensure_author, only: [:edit, :update]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to sub_url(@post.sub.title)
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

  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

  def ensure_author
    @post = Post.find(params[:id])
    current_user == @post.author
  end
end
