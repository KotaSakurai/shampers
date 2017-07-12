class EmailValidator < ActiveModel::Validator
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  def validate(user)
    if invalid_email(user.email)
      user.errors.add(:base, "invalid")
    end
  end

  private

  def invalid_email(email)
    return true unless email.match(VALID_EMAIL_REGEX)
  end
end
