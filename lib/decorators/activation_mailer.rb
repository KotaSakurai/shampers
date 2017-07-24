class ActivationMailer
  def initialize(user)
    @user = user
  end

  def save
    @user.save && send_activation_email(@user)
  end

  def send_activation_email(user)
    UserMailer.account_activation(user).deliver_now
  end
end
