class PasswordsController < ApplicationController
  def forgot
  end

  def generate
    user = User.find_by_email(params[:email])
    password = random_password 6
    if user
      UserMailer.password_email(user.email, password).deliver
      user.update_attributes(:password => password)
    end
  end

  private

  def random_password length
    alphabet = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..length).collect { |a| alphabet[rand(alphabet.length)] }.join
  end
end
