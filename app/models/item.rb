class Item < ApplicationRecord
  belongs_to :user
<<<<<<< HEAD
  has_many :bookings
  has_one_attached :photo
=======

  validates :name, presence: true
  validates :name, uniqueness: true
>>>>>>> master
end
