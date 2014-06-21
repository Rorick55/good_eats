require 'spec_helper'

  feature "User views a list of restaurants", %Q{
    As a user I would like to navigate to a page
    and be able to see a list of restaurants
    names and addresses to find one close to me.
  } do

    scenario 'User views a list of restaurants' do
      restaurants = []
      restaurant_attrs = [
        {name: 'Lotus Thai Bistro', address: '3019 Carlsbad village dr.', city: 'Carlsbad', state: 'California', zip_code: 92008, description: 'Great Thai food', category: 'Thai'},
        {name: 'The Compass', address: '123 Carlsbad blvd.', city: 'Carlsbad', state: 'California', zip_code: 92008, description: 'Old fashiond bar/restaurant', category: 'Bar'}
      ]
      restaurant_attrs.each do |attrs|
        restaurants << Restaurant.create(attrs)
      end

      visit '/restaurants'
      restaurants.each do |restaurant|
      expect(page).to have_content restaurant.name
      expect(page).to have_content restaurant.city
    end
  end
end
