require File.dirname(__FILE__) + '/../spec_helper'

describe ContactController do

  describe "send_mail" do

    it "send mail and display a success message" do
      @controller.stubs(:current_user).returns(user = User.new(:email => 'foo@bar.com', :first_name => 'first', :last_name => 'last', :zip_code => '12345'))
      post :send_mail, :name => "Name", :email => 'Email', :comments => "Great!"
      flash[:notice].should == 'Your comments have been sent.'
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end
end
