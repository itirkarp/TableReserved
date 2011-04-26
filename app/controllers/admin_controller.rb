class AdminController < ApplicationController
  before_filter :login_required
  before_filter :admin_login

  def show
    @restaurant = Restaurant.new
  end

end
