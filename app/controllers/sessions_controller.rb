class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      log_in(@user)
      redirect_to @user
    else
      flash.now[:alert] = "Email not registered"
      render 'new'
    end
  end

  def destroy
  end
end
