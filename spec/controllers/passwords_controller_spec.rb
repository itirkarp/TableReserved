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
end
