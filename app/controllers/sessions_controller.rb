class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      session[:user_id] = user.id
      redirect_to @user
    else
      flash.now[:alert] = "Email not registered"
      render 'new'
    end
  end

  def destroy
  end
end
