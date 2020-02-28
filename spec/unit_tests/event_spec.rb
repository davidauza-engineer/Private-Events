require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:test_user) { User.new(name: 'Test', email: 'email@email.com') }
  let(:test_event) do
    Event.new(name: 'Test Title', description: 'Cool Event',
              date: 1.day.after, creator_id: 1)
  end
  let(:past_event) do
    Event.new(name: 'Past Event', description: 'So cool event',
              date: 1.day.ago, creator_id: 1)
  end

  describe 'valid event creation' do
    it 'successfuly creates an user with valid input' do
      test_user.save
      expect(test_event.valid?).to eq(true)
    end
  end

  describe 'invalid event creation' do
    it 'rejects a blank name for the event' do
      test_user.save
      test_event.name = ''
      expect(test_event.valid?).to eq(false)
    end

    it 'rejects a nil name for the event' do
      test_user.save
      test_event.name = nil
      expect(test_event.valid?).to eq(false)
    end

    it 'rejects a name for the event which is too short' do
      test_user.save
      test_event.name = 'hi'
      expect(test_event.valid?).to eq(false)
    end

    it 'rejects a name for the event which is too long' do
      test_user.save
      test_event.name = 'a' * 51
      expect(test_event.valid?).to eq(false)
    end

    it 'rejects an empty date field' do
      test_user.save
      test_event.date = ''
      expect(test_event.valid?).to eq(false)
    end

    it 'rejects a nil date field' do
      test_user.save
      test_event.date = nil
      expect(test_event.valid?).to eq(false)
    end

    it 'rejects a date in the past' do
      test_user.save
      test_event.date = 1.day.ago
      expect(test_event.valid?).to eq(false)
    end

    it 'rejects a description longer than 140 characters' do
      test_user.save
      test_event.description = 'a' * 141
      expect(test_event.valid?).to eq(false)
    end

    it 'rejects an event if no it has no valid creator_id' do
      expect(test_event.valid?).to eq(false)
    end
  end

  describe 'tests for scopes' do
    it 'returns the events from the past' do
      test_user.save
      past_event.save
      expect(Event.past_events.first).to eq(Event.first)
    end

    it 'returns the events from the past' do
      test_user.save
      test_event.save
      expect(Event.upcoming_events.first).to eq(Event.first)
    end
  end
end
