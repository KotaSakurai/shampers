class PasswordresetMailer < ApplicationController
  def initialize(user)
    @user = user
  end

  def save
    @user.save && @user.send_password_reset_email
  end
end
