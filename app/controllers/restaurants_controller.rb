class RestaurantsController < ApplicationController
  before_filter :login_from_cookie, :only => [:show, :show_admin, :edit]
  before_filter :login_required
  before_filter :admin_login, :only => [:show_admin, :remove_from_exclusives, :add_to_exclusives, :edit, :destroy]

  def show
    @restaurant = Restaurant.find_by_id(params[:id])
  end

  def show_admin
    @restaurant = Restaurant.find_by_id(params[:id])
  end

  def create
    # might go wrong with IE coz it includes the entire path of the file being sent, so original_filename will have full path
    # in this case sanitize the name

    #TODO: move into model

    photo = params[:restaurant][:photo]
    path = File.join("public/images", photo.original_filename)
#    File.open(path, "wb") {|f| f.write(photo.read)}
    params[:restaurant][:photo] = photo.original_filename

    photo = params[:restaurant][:logo]
    path = File.join("public/images", photo.original_filename)
#    File.open(path, "wb") {|f| f.write(photo.read)}
    params[:restaurant][:logo] = photo.original_filename

    restaurant = Restaurant.new(params[:restaurant])
    restaurant.save_with_images(params[:restaurant])
    flash[:notice] = 'Restaurant created successfully'
    redirect_to admin_url
  end

  def remove_from_exclusives
    restaurant = Restaurant.find(params[:id])
    restaurant.visible = 0
    restaurant.save
    redirect_to admin_url
  end

  def add_to_exclusives
    restaurant = Restaurant.find(params[:id])
    restaurant.visible = 1
    restaurant.save
    redirect_to admin_url
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update

    #TODO: fix this when you fix create

    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update_attributes(params[:restaurant])
      redirect_to admin_url, :notice => "Restaurant details have been updated."
    else
      redirect_to edit_restaurant_url(@restaurant.id), :notice => 'There were errors. Please check all values and try again.'
    end
  end

  def destroy
    Restaurant.find(params[:id].to_i).destroy
    redirect_to admin_url, :notice => "The restaurant was deleted."
  end

end
