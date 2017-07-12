class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
            uniqueness: { case_sensitive: false }
  validates_with EmailValidator
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  before_save :downcase_email
  has_secure_password

  private

  def downcase_email
    self.email.downcase!
  end

end