class UserMailer < ApplicationMailer
  def welcome_email(password)
    @user = params[:user]
    @password = password
    mail(to: @user.email, subject: "Welcome to the Documentation portal!")
  end
end
