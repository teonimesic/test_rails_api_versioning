class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
  validates :picture, presence: true
  validates :gender, inclusion: { in: %w(M F) }, allow_blank: true

  has_one :address, dependent: :destroy
  accepts_nested_attributes_for :address
end
