class Review < ActiveRecord::Base
  belongs_to :restaurant

  validates :body, presence: true
  validates :restaurant_id, presence: true
  validates :rating, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }
end
