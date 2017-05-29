class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :picture, presence: true
end
