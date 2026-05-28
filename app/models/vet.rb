class Vet < ApplicationRecord
  has_many :appointments

  # Validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :specialization, presence: true

  # Scopes
  scope :by_specialization, ->(specialization) { where(specialization: specialization) }

  # Callbacks
  before_validation :normalize_email

  private

  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end