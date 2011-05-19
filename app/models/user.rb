class User < ActiveRecord::Base
  # new columns need to be added here to be writable through mass assignment
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :zip_code, :terms, :remember_token

  attr_accessor :password
  before_save :prepare_password

  validates_uniqueness_of :email
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 6, :allow_blank => true
  validates_presence_of :first_name, :last_name, :message => "First name or last name is invalid"
  validates_presence_of :zip_code
  validates_length_of :zip_code, :is => 5, :message => "is invalid"
  validates_numericality_of :zip_code, :message => "is invalid"
  validates_acceptance_of :terms, :on => :create, :message => "Terms must be accepted"

  def self.authenticate(login, pass)
    user = find_by_email(login.downcase)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end

  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, password_salt)
  end

  def admin?
    email == 'admin@tablereserved.com'
  end

  def remember_me
    token = Digest::SHA1.hexdigest(self.email)
    self.remember_token = token
    self.save(:validate => false)
    token
  end

  def forget_me
    self.remember_token = nil
    self.save(false)
  end

  private

  def prepare_password
    unless password.blank?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
end
