class RestaurantsController < ApplicationController
  before_filter :login_required

  def show
    @restaurant = Restaurant.find_by_id(params[:id])
  end

end
