class User < ApplicationRecord
  PASSWORD_LENGTH = 15

  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_validation :generate_password, on: :create
  after_create :send_password
  # For some reason, I have to put this callback under rolify. Otherwise, the same role is assigned
  # to the new record twice
  after_create :assign_default_role

  validate :must_have_role, on: :update

  private

  def assign_default_role
    self.add_role(:customer) if self.roles.blank?
  end

  def generate_password
    self.password = Devise.friendly_token(PASSWORD_LENGTH) if self.password.blank?
  end

  def send_password
    UserMailer.with(user: self).welcome_email(self.password).deliver_later
  end

  def must_have_role
    unless self.roles.any?
      errors.add(:role, 'A user must have at least one role.')
    end
  end
end