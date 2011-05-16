require File.dirname(__FILE__) + '/../spec_helper'

describe PasswordsController do

  it "should generate an email with a password" do
    email = "some@email.com"
    mock_email = mock()
    @controller.stubs(:random_password).with(6).returns('random')
    User.stubs(:find_by_email).returns(User.new :email => email)
    UserMailer.should_receive(:password_email).with(email, 'random').and_return(mock_email)
    mock_email.should_receive(:deliver)
    post :generate, :email => "some@email.com"
  end

  describe "update" do

    it "should redirect to user page if new password is not present" do
      post :update, :new_password => nil
      flash[:notice].should == "The new password is invalid. It should have a minimum of 6 characters."
    end

    it "should redirect to user page if new password is invalid" do
      @controller.stubs(:current_user).returns(user = User.new)
      user.stubs(:encrypt_password).returns(user.password_hash)
      post :update, :new_password => "wrong"
      flash[:notice].should == "The new password is invalid. It should have a minimum of 6 characters."
    end

    it 'should redirect to user page if old password is incorrect' do
      @controller.stubs(:current_user).returns(user = User.new)
      user.stubs(:encrypt_password).returns("invalid")
      post :update, :new_password => "correct"
      flash[:notice].should == "The current password is incorrect. Your password was not updated."
    end

    it "should display success message if password is updated" do
      @controller.stubs(:current_user).returns(user = User.new(:email => 'foo@bar.com', :first_name => 'first', :last_name => 'last', :zip_code => '12345'))
      user.stubs(:encrypt_password).returns(user.password_hash)
      post :update, :new_password => "correct", :password_confirmation => "correct"
      flash[:notice].should == "Your password was updated successfully."
    end
  end
end
