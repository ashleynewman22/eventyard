class Cart < ApplicationRecord
  belongs_to :item
  belongs_to :user
  validates :status, inclusion: { in: %w[pending accepted declined] }

  def total_price
    item.price * (end_date - start_date).to_i
  end

  # STATUSES = %[pending]

end
