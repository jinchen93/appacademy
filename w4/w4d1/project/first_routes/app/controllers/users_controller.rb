class UsersController < ApplicationController
  def index
    if params[:id]
      redirect_to action: 'show', id: params[:id]
    elsif params[:username]
      user = User.find_by(username: params[:username])
      user_id = user.id
      redirect_to action: 'show', id: user_id
    else
      @users = User.all
      render json: @users
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render(
        json: user.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    render json: user
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: user
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
