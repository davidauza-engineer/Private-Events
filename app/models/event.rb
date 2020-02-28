class Event < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }
  validates :date, presence: true
  validate :date_is_in_the_future
  validates :description, length: { maximum: 140 }
  belongs_to :creator, class_name: 'User'
  has_many :attendances, foreign_key: :attended_event_id
  has_many :attendees, through: :attendances, source: :attendee

  def date_is_in_the_future
    errors.add(:date, "can't be in the past") if !date.nil? && date < Time.now
  end

  scope :upcoming_events, -> { where('date >= ?', Time.now) }
  scope :past_events, -> { where('date < ?', Time.now) }
end
