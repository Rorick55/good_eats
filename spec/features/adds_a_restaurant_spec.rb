require 'spec_helper'

feature "User adds a new restaurant", %Q{
  As a user I want to be able to add a new
  restaurant to let other people know about it
  and review it.
} do

  scenario 'User adds a new restaurant' do
    attrs = {
      name: 'Lotus Thai Bistro',
      address: '3019 Carlsbad village dr.',
      city: 'Carlsbad',
      state: 'California',
      zip_code: 92008,
      description: 'Great Thai food',
      category: 'Thai'
    }
    restaurant = Restaurant.new(attrs)

    visit '/restaurants/new'
    fill_in 'Name', with: restaurant.name
    fill_in 'Address', with: restaurant.address
    fill_in 'City', with: restaurant.city
    fill_in 'State', with: restaurant.state
    fill_in 'Zip code', with: restaurant.zip_code
    fill_in 'Description', with: restaurant.description
    fill_in 'Category', with: restaurant.category
    click_on 'Submit'

    expect(page).to have_content 'Success'
    expect(page).to have_content restaurant.name
    expect(page).to have_content restaurant.address
    expect(page).to have_content restaurant.city
    expect(page).to have_content restaurant.state
    expect(page).to have_content restaurant.zip_code
  end

  scenario 'without required attributes' do
    visit '/restaurants/new'
    click_on 'Submit'

    expect(page).to_not have_content 'Success'
    expect(page).to have_content "can't be blank"
    expect(page).to_not have_content restaurant.name
  end

  scenario 'user tries to add a duplicate restaurant' do
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

    visit '/restaurants/new'
    fill_in 'Name', with: restaurant.name
    fill_in 'Address', with: restaurant.address
    fill_in 'City', with: restaurant.city
    fill_in 'State', with: restaurant.state
    fill_in 'Zip code', with: restaurant.zip_code
    fill_in 'Description', with: restaurant.description
    fill_in 'category', with: restaurant.category
    click_on 'Submit'

    expect(page).to have_content 'has already been taken'
    expect(page).to_not have_content 'Success'
  end
end
