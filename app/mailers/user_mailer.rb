class UserMailer < ApplicationMailer
  default from: 'Blocmetrics'

  def welcome_email(user)
    @user = user
    @url = 'http://example.com/Login'
    mail(to: @user.email, subject: "Welcome to Blocmetrics") do |format|
      format.html
      format.text
    end
  end

  def password_reset(user)
    @user = user
    @reset_url = edit_password_reset_url(@user.password_reset_token)
    mail(to: @user.email, subject: "Password Reset") do |format|
      format.html
      format.text
    end
  end
end
