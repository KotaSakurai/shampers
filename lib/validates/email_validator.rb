class EmailValidator < ActiveModel::Validator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  def validate(user)
    if invalid_email(user.email)
      user.errors.add(:base, "invalid")
    end
    # unless kawaii_email_address(user.email)
    #   user.errors.add(:base, "invalid for kawaii")
    # end
  end

  private

  def invalid_email(email)
    return true unless email.match(VALID_EMAIL_REGEX)
  end

  # def kawaii_email_address(email)
  #   KawaiiEmailAddress::Validator.new(email).valid?
  # end
end
