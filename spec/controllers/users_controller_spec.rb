require File.dirname(__FILE__) + '/../spec_helper'

describe UsersController do
  fixtures :all

  describe "new" do

    it "should render new template" do
      get :new
      response.should render_template(:new)
    end

  end

  describe "create" do
    it "should render new template when model is invalid" do
      User.any_instance.stubs(:valid?).returns(false)
      post :create, :terms => "1"
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

    it "should allow admin user to edit any user" do
      User.stubs(:find).returns(User.new :email => 'email')
      @controller.stubs(:current_user_is_admin?).returns(true)
      @controller.stubs(:current_user).returns(User.new :email => "admin@tablereserved.com")
      get :edit, :id => '1'
      assigns[:user].email.should == 'email'
    end

    it "should allow the logged in user to edit himself" do
      user = User.new :email => 'email'
      User.stubs(:find).returns(user)
      @controller.stubs(:current_user_is_admin?).returns(false)
      @controller.stubs(:current_user).returns(user)
      get :edit, :id => '1'
      assigns[:user].email.should == 'email'
    end

    it "should not allow the logged in user to edit any other user" do
      User.stubs(:find).returns(User.new :email => 'email')
      @controller.stubs(:current_user).returns(User.new :email => "other_email")
      get :edit, :id => '1'
      assigns[:user].should be_nil
    end
  end

  describe "admin_update" do

    it "should redirect to all users when user is successfully updated" do
      @controller.stubs(:current_user).returns(User.new(:email => 'admin@tablereserved.com'))
      User.stubs(:find).with(1).returns(user = User.new)
      user.stubs(:update_attributes).returns(true)
      put :admin_update, :id => 1
      response.should redirect_to(all_users_url)
    end

  end

  describe "show" do
    it "should show the current user" do
      @controller.stubs(:current_user).returns(User.new :first_name => "admin")
      get :show
      assigns[:user].first_name.should == "admin"
    end
  end

  it "should expose all user data as a csv file" do
    @controller.stubs(:current_user).returns(User.first)
    get :all_users_csv
    response.body.include?("foo@example.com").should == true
  end

  it "should expose all the user information" do
    @controller.stubs(:current_user).returns(User.new(:email => 'admin@tablereserved.com'))
    User.stubs(:find).returns([User.new, User.new])
    get :all_users
    assigns[:users].count.should == 2
  end

  describe "destroy" do
    it "should delete the user" do
      @controller.stubs(:current_user).returns(User.new(:email => "admin@tablereserved.com"))
      user = User.new.save(:validate => false)
      User.stubs(:find).returns(user)
      user.should_receive(:destroy)
      post :destroy, :id => user.id.to_s

      response.should redirect_to(all_users_url)
    end
  end
end
