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

  it "should provide the restaurant for the admin view" do
    @controller.stubs(:current_user).returns(User.first)
    Restaurant.should_receive(:find).with(1).and_return(Restaurant.new(:name => "Restaurant"))
    get :show_admin, :id => 1
    assigns[:restaurant].name == "Restaurant"
  end
end
