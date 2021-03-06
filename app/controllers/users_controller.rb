class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Account created successfully!'
      log_in(@user)
      redirect_to @user
    else
      flash.now[:danger] = @user.errors.full_messages
      render new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @user_events = @user.events
    @upcoming_events = @user_events.upcoming_events
    @prev_events = @user_events.past_events
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
