class PasswordresetMailer
  def initialize(user)
    @user = user
  end

  def create_reset_digest
    create_reset_digest(@user) && send_password_reset_email(@user)
  end

  private
  def create_reset_digest(user)
    user.reset_token = User.new_token
    update_attributes(reset_digest: User.digest(user.reset_token), reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email(user)
    UserMailer.password_reset(user).deliver_now
  end
end
