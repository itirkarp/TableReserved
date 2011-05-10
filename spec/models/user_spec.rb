require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  def new_user(attributes = {})
    attributes[:email] ||= 'foo@example.com'
    attributes[:zip_code] ||= '12345'
    attributes[:first_name] ||= 'foo'
    attributes[:last_name] ||= 'bar'
    attributes[:password] ||= 'abc123'
    attributes[:password_confirmation] ||= attributes[:password]
    User.new(attributes)
  end

  before(:each) do
    User.delete_all
  end

  describe "new" do
    it "should be valid" do
      new_user.should be_valid
    end

    it "should require password" do
      new_user(:password => '').should have(1).error_on(:password)
    end

    it "should require well formed email" do
      new_user(:email => 'foo@bar@example.com').should have(1).error_on(:email)
    end

    it "should validate uniqueness of email" do
      new_user(:email => 'bar@example.com').save!
      new_user(:email => 'bar@example.com').should have(1).error_on(:email)
    end

    it "should validate password is longer than 3 characters" do
      new_user(:password => 'bad').should have(1).error_on(:password)
    end

    it "should require matching password confirmation" do
      new_user(:password_confirmation => 'nonmatching').should have(1).error_on(:password)
    end

  end

  describe "create" do
    it "should generate password hash and salt on create" do
      user = new_user
      user.save!
      user.password_hash.should_not be_nil
      user.password_salt.should_not be_nil
    end
  end

  describe "authenticate" do
    it "should authenticate by email" do
      user = new_user(:email => 'foo@bar.com', :password => 'secret')
      user.save!
      User.authenticate('foo@bar.com', 'secret').should == user
    end

    it "should not authenticate bad password" do
      new_user(:password => 'secret').save!
      User.authenticate('foobar', 'badpassword').should be_nil
    end

  end

  describe "admin?" do
    it "should return true for an admin user" do
      user = new_user(:email => 'admin@tablereserved.com')
      user.admin?.should == true
    end

    it "should return false for a non admin user" do
      user = new_user(:email => 'otheruser@tablereserved.com')
      user.admin?.should == false
    end

  end

  it "should set the remember token" do
    token = "token"
    user = new_user(:email => 'foo@bar.com')
    Digest::SHA1.stubs(:hexdigest).with(user.email).returns(token)
    user.remember_me.should == token
    user.remember_token.should == token
  end
end
