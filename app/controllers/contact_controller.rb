class ContactController < ApplicationController
  before_filter :login_from_cookie, :only => [:show]
  before_filter :login_required

  def show
  end

  def send_mail
    UserMailer.contact_email(params).deliver
    redirect_to contact_url, :notice => 'Your comments have been sent.'
  end
end
