class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user
      log_in(@user)
      redirect_to @user
    else
      flash.now[:alert] = 'Email not registered.'
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url
  end
end
