require "spec_helper"

describe UserMailer do

  it "should send the password email" do
    password = "password"
    email = UserMailer.password_email("test@test.com", password).deliver
    ActionMailer::Base.deliveries.should_not be_empty
    email.subject.should == "Temporary Password"
    email.encoded.include?(password).should be_true
  end

  it "should send the contact email" do
    name = 'Name'
    email_id = 'email@at.com'
    comments = 'Awesome'

    email = UserMailer.contact_email({:name => name, :email => email_id, :comments => comments}).deliver

    ActionMailer::Base.deliveries.should_not be_empty
    email.subject.should == "Comments from #{name}"
    email.encoded.include?(email_id).should be_true
    email.encoded.include?(comments).should be_true
  end
end
