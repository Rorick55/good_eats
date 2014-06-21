class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)
    @review.restaurant_id = @restaurant.id
      if @review.save
        flash[:notice] = 'Success! You added a review!'
        redirect_to @restaurant
      else
        render :template => 'reviews/new'
      end
  end


  private
  def review_params
    params.require(:review).permit(:rating, :body)
  end

end
