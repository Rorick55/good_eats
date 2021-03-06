class RestaurantsController < ApplicationController

  def index
    @restaurants = Restaurant.order('created_at DESC').limit('10')
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
      if @restaurant.save
        flash[:notice] = "Success! You added #{@restaurant.name}"
        redirect_to @restaurant
      else
        render "restaurants/new"
      end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :city, :state, :zip_code, :description, :category)
  end
end
