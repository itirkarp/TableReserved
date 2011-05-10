class AdminController < ApplicationController
  before_filter :login_from_cookie
  before_filter :login_required
  before_filter :admin_login

  def show
    @restaurant = Restaurant.new
    @restaurants = Restaurant.find(:all)
  end

end
