require 'spec_helper'

feature 'User adds a review to a restaurant', %Q{
  As a user I would like to be able to navigate to
  a page where I can add a review to a specific restaurant.
} do

  scenario 'user adds a review' do
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

    attrs = {
      rating: 4,
      body: 'Dont go on a monday. Food was so so and the service was sub-par'
    }
    review = Review.new(attrs)

    visit "restaurants/#{restaurant.id}/reviews/new"
    select review.rating, from: 'Rating'
    fill_in 'Review', with: review.body
    click_on 'Submit'

    expect(page).to have_content review.rating
    expect(page).to have_content review.body
    expect(page).to have_content restaurant.name
    expect(page).to have_content 'Success'
  end

  scenario 'user fails to fill out all required attributes' do
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

    visit "restaurants/#{restaurant.id}/reviews/new"
    click_on 'Submit'

    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content "Success"
  end
end
