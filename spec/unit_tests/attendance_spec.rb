require 'rails_helper'

RSpec.describe Attendance, type: :model do
  let(:test_user) { User.new(name: 'David', email: 'david@gmail.org') }
  let(:future_test_event) { Event.new(name: "Next year's event", date: 1.year.after, creator_id: 1) }
  let(:past_test_event) { Event.new(name: "Last year's event", date: 1.year.ago, creator_id: 1) }
  let(:future_event_attendance) { Attendance.new(attendee_id: 1, attended_event_id: 1) }
  let(:past_event_attendance) { Attendance.new(attendee_id: 1, attended_event_id: 2) }

  def store_in_database
    test_user.save
    future_test_event.save
    past_test_event.save
    future_event_attendance.save
    past_event_attendance.save
  end

  scenario 'retrieve the events an user have attended' do
    store_in_database
    # rubocop:disable Style/DoubleNegation
    expect(!!User.first.events_attended).to eq(true)
  end

  scenario 'retrieve the users who have attended to an event' do
    store_in_database
    expect(!!Event.first.attendees).to eq(true)
    # rubocop:enable Style/DoubleNegation
  end
end
