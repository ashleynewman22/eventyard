class Item < ApplicationRecord
  belongs_to :user
  has_many :carts
  has_one_attached :photo

  validates :name, presence: true
  validates :name, uniqueness: true
end
