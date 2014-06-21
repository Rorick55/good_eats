class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.order('created_at DESC')
  end
end
