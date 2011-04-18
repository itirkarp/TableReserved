class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :zip_code, :terms

  attr_accessor :password
  before_save :prepare_password

  validates_uniqueness_of :email, :allow_blank => true
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :zip_code, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6, :allow_blank => true
  validates_acceptance_of :terms, :on => :create, :message => "Terms must be accepted"

  def self.authenticate(login, pass)
    user = find_by_email(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
