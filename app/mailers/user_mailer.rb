class UserMailer < ApplicationMailer
  default from: 'Notifications@example.com'

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/Login'
    mail(to: @user.email, subject: "Welcome to Blocmetrics") do |format|
      format.html
      format.text
    end
  end
end
