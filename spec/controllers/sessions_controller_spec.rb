require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do
  fixtures :all
#  render_views

  it "should render new template" do
    get :new
    response.should render_template(:new)
  end

  describe "create" do
    it "should render new template when authentication is invalid" do
      User.stubs(:authenticate).returns(nil)
      post :create
      response.should redirect_to(new_session_url)
      session['user_id'].should be_nil
    end

    it "should redirect to home when authentication is valid" do
      User.stubs(:authenticate).returns(User.first)
      post :create
      response.should redirect_to(root_url)
      session['user_id'].should == User.first.id
    end

    it "should redirect to the admin page if admin logs in" do
      User.stubs(:authenticate).returns(User.new(:email => 'admin@tablereserved.com'))
      post :create
      response.should redirect_to(admin_url)
    end
  end

  describe "show" do
    it "should provide all the restaurants" do
      @controller.stubs(:current_user).returns(User.first)
      Restaurant.stub(:find).and_return([Restaurant.new(:name => "Awesome", :photo => "/images/first_restaurant.jpg", :logo => "/images/logo.gif", :offer => "Enjoy 30% off on your total bill", :cuisine => "Italian", :offer_end_date => "2011-05-15", :offer_valid_days => "Saturday and Sunday", :offer_valid_times => "Between 12 pm and 10 pm", :address => "Some street, some city", :phone => "1234567890")])
      get :show
      assigns[:restaurants].first.name.should == "Awesome"
    end

    it "should filter out invisible retaurants" do
      @controller.stubs(:current_user).returns(User.first)
      visible = Restaurant.new(:name => 'one', :visible => true)
      invisible = Restaurant.new(:name => 'two', :visible => false)
      Restaurant.stub(:find).and_return([visible, invisible])
      get :show
      assigns[:restaurants].count.should == 1
      assigns[:restaurants].first.name.should == visible.name
    end
  end
end
