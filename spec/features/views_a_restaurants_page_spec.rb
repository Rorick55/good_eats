require 'spec_helper'


feature 'User views a restaurants show page', %Q{
  As a user I want to be able to navigate to
  a restaurants personal page and see their detailed
  information.
} do


  scenario 'User visits a restaurants page' do
    attrs = {
      name: 'Lotus Thai Bistro',
      address: '3019 Carlsbad village dr.',
      city: 'Carlsbad',
      state: 'California',
      zip_code: 92008,
      description: 'Great Thai food',
      category: 'Thai'
    }

    restaurant = Restaurant.create(attrs)

    visit "/restaurants/#{restaurant.id}"
    expect(page).to have_content restaurant.name
    expect(page).to have_content restaurant.address
    expect(page).to have_content restaurant.city
    expect(page).to have_content restaurant.state
    expect(page).to have_content restaurant.zip_code
  end
end
