class PasswordsController < ApplicationController
  def forgot
  end

  def generate
    user = User.find_by_email(params[:email].downcase)
    password = random_password 6
    if user
      UserMailer.password_email(user.email, password).deliver
      user.update_attributes(:password => password)
    end
  end

  def update
    redirect "The new password is invalid. It should have a minimum of 6 characters." and return if params[:new_password].blank?
    if current_user.password_hash == current_user.encrypt_password(params[:old_password])
      update_password(params)
    else
      redirect "The current password is incorrect. Your password was not updated."
    end
  end

  private

  def random_password length
    alphabet = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..length).collect { |a| alphabet[rand(alphabet.length)] }.join
  end

  def update_password params
    current_user.password = params[:new_password]
    current_user.password_confirmation = params[:password_confirmation]
    message = current_user.save ? "Your password was updated successfully." : "The new password is invalid. It should have a minimum of 6 characters."
    redirect message
  end

  def redirect message
    redirect_to user_url, :notice => message
  end

end
