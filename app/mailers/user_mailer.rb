class UserMailer < ActionMailer::Base
  default :from => "admin@tablereserved.com"

  def password_email email, password
    @password = password
    mail(:to => email, :subject => "Your temporary password for TableReserved")
  end

  def contact_email params
    @name = params[:name]
    @email = params[:email]
    @comments = params[:comments]
    mail(:to => "admin@tablereserved.com", :subject => "Comments from #{@name}")
  end

end
