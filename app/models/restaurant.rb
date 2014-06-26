class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true, uniqueness: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  def average_rating
    count = 0
    total = 0
    average_rating =
    self.reviews.each do |review|
      total = total + review.rating.to_f
      count +=1
    end
    if count == 0
      average_rating = 'N/A'
    else
      average_rating = total/count
      average_rating = average_rating.round(2)
    end
    average_rating
  end
end
