class EventsController < ApplicationController
  def index
    @all_events = Event.all
    @past = @all_events.past_events
    @future = @all_events.upcoming_events
    @all_events = nil
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    if session[:user_id]
      @event = Event.new
    else
      flash[:danger] = 'You need to be logged in to create an event.'
      redirect_to login_path
    end
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
