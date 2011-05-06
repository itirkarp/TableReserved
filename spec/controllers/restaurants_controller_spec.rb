require File.dirname(__FILE__) + '/../spec_helper'

describe RestaurantsController do
#  fixtures :all
#  render_views

  describe "show" do
    it "should provide restaurant details" do
      @controller.stubs(:current_user).returns(User.first)
      Restaurant.should_receive(:find_by_id).with(1).and_return(Restaurant.new(:name => "Awesome"))
      get :show, :id => 1
      assigns[:restaurant].name.should == "Awesome"
    end
  end

  describe "create" do
    it "should save the restaurant and redirect"
  end

  it "should provide the restaurant for the admin view"

  it "edit should assign a restaurant from the params"

  describe "update" do
    it "should render edit template when restaurant is invalid" do
      @controller.stubs(:current_user).returns(User.new(:email => "admin@tablereserved.com"))
      Restaurant.stubs(:find).returns(Restaurant.new)
      Restaurant.any_instance.stubs(:valid?).returns(false)
      put :update, :id => "1"
      response.should redirect_to(edit_restaurant_url)
    end

    it "should redirect when restaurant is valid" do
      @controller.stubs(:current_user).returns(User.new(:email => "admin@tablereserved.com"))
      Restaurant.stubs(:find).returns(Restaurant.new)
      Restaurant.any_instance.stubs(:valid?).returns(true)
      put :update, :id => "1"
      response.should redirect_to(admin_url)
    end
  end

  it "should delete restaurant from id in params" do
    @controller.stubs(:current_user).returns(User.new(:email => "admin@tablereserved.com"))
    restaurant = Restaurant.new.save!
    Restaurant.stubs(:find).returns(restaurant)
    restaurant.should_receive(:destroy)
    post :destroy, :id => restaurant.id.to_s
  end
end
