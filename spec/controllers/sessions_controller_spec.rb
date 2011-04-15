require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do
  fixtures :all
  render_views

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
  end

  describe "show" do
    it "should provide all the restaurants" do
      @controller.stubs(:current_user).returns(User.first)
      Restaurant.stub(:find).and_return([Restaurant.new(:name => "Awesome")])
      get :show
      assigns[:restaurants].first.name.should == "Awesome"
    end
  end
end
