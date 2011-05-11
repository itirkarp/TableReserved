class UserMailer < ActionMailer::Base
  default :from => "itirkarp@gmail.com"

  def password_email email, password
    @password = password
    mail(:to => email, :subject => "Your temporary password for TableReserved")
  end

end
