class RestaurantsController < ApplicationController
  before_filter :login_required

  def show
    @restaurant = Restaurant.find_by_id(params[:id])
  end

  def show_admin
    @restaurant = Restaurant.find(params[:id])
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


end
