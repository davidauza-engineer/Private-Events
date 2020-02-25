class User < ApplicationRecord
  validates :name, presence: true, length: { minimum: 4, maximum: 50 },
            uniqueness: true
  validates :email, presence: true, length: { minimum: 4, maximum: 140 },
            uniqueness: true
end
