class User < ApplicationRecord
  before_save :downcase_mail

  has_secure_password

  validates :name, presence: true, lenght: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, lenght: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, lenght: {minimum: 6}

  private
  def downcase_mail
    email.downcase!
  end
end
