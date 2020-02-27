class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @user = User.find(session[:user_id])
    @event = @user.events.build(event_params)
    if @event.save
      flash[:success] = 'Event created successfully!'
      redirect_to events_path
    else
      flash.now[:danger] = @event.errors.full_messages
      render new_event_path
    end
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :description)
  end
end
