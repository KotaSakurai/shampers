class ActivationMailer < ApplicationController
  def initialize(user)
    @user = user
  end

  def save
    @user.save && @user.send_activation_email
  end
end
