class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      user_params[:username],
      user_params[:password]
    )
    if user.nil?
      flash[:errors] = ["invalid"]
      render :new
    else
      login!(user)
      redirect_to user_url(user.id)
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
