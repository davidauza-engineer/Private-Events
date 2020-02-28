class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { minimum: 6, maximum: 140 },
                    uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  has_many :events, foreign_key: :creator_id
  has_many :attendances, foreign_key: :attendee_id
  has_many :events_attended, through: :attendances, source: :attended_event
end
