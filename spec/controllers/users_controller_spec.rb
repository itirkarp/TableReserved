require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all
  render_views

  describe "new" do

    it "should render new template" do
      get :new
      response.should render_template(:new)
    end

  end

  describe "create" do
    it "should render new template when model is invalid" do
      User.any_instance.stubs(:valid?).returns(false)
      post :create
      response.should render_template(:new)
    end

    it "should redirect when model is valid" do
      User.any_instance.stubs(:valid?).returns(true)
      post :create
      response.should redirect_to(root_url)
      session['user_id'].should == assigns['user'].id
    end

  end

  describe "edit" do
    it "should redirect when not logged in" do
      get :edit, :id => "ignored"
      response.should redirect_to(login_url)
    end

    it "should render edit template" do
      @controller.stubs(:current_user).returns(User.first)
      get :edit, :id => "ignored"
      response.should render_template(:edit)
    end

  end

  describe "update" do
    it "should redirect when not logged in" do
      put :update, :id => "ignored"
      response.should redirect_to(login_url)
    end

    it "should render edit template when user is invalid" do
      @controller.stubs(:current_user).returns(User.first)
      User.any_instance.stubs(:valid?).returns(false)
      put :update, :id => "ignored"
      response.should render_template(:edit)
    end

    it "should redirect when user is valid" do
      @controller.stubs(:current_user).returns(User.first)
      User.any_instance.stubs(:valid?).returns(true)
      put :update, :id => "ignored"
      response.should redirect_to(root_url)
    end

  end

  describe "show" do
    it "should make the user details available" do
      controller.stub(:current_user).and_return(User.new(:username => "name"))
      get :show
      assigns[:user].username.should == "name"
    end
  end
end
