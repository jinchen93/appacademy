class SubsController < ApplicationController
  before_filter :ensure_moderator, only: [:edit, :update]

  def index
    @all_subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to subs_url
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def show
    @sub = Sub.find_by(title: params[:title])
    render :show
  end

  def edit
    @sub_old_title = @sub.title
    render :edit
  end

  def update
    if @sub.update_attributes(sub_params)
      redirect_to sub_url(@sub.title)
    else
      flash[:errors] = @sub.errors.full_messages
      redirect_to edit_sub_url(params[:old_title])
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

  def ensure_moderator
    redirect_to sub_url(params[:title]) unless moderator?
  end
end
