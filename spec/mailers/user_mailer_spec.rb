require "spec_helper"

describe UserMailer do
  it "should send the password email" do
    password = "password"
    email = UserMailer.password_email("test@test.com", password).deliver
    ActionMailer::Base.deliveries.should_not be_empty
    email.subject.should == "Your temporary password for TableReserved"
    email.encoded.include?(password).should be_true
  end
end
