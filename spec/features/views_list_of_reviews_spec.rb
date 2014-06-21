require 'spec_helper'

feature 'User views all reviews for a restaurant', %Q{
  As a user I want to be able to navigate to a restaurants page
  and see all of the reviews for that restaurant.
} do

  scenario 'user views a list of reviews' do
    reviews = []
    restaurant_attrs = {
      name: 'Lotus Thai Bistro',
      address: '3019 Carlsbad village dr.',
      city: 'Carlsbad',
      state: 'California',
      zip_code: 92008,
      description: 'Great Thai food',
      category: 'Thai'
    }
    restaurant = Restaurant.create(restaurant_attrs)
    review_attrs = [
      {rating: 5, body: 'Great service and greate food. The Pad Thai and Panang Curry are amazing, but I have ahd better Pad See Ew.'},
      {rating: 4, body: 'Dont go on a monday. Food was so so and the service was sub-par'}
    ]
    review_attrs.each do |attrs|
      review = Review.new(attrs)
      review.restaurant_id = restaurant.id
      review.save(attrs)
      reviews << review
    end

    visit "/restaurants/#{restaurant.id}"
    reviews.each do |review|
      expect(page).to have_content review.rating
      expect(page).to have_content review.body
    end
  end
end
