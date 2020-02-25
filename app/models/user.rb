class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 50 },
            uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { minimum: 4, maximum: 140 },
            uniqueness: true, format: { with: VALID_EMAIL_REGEX }
end
