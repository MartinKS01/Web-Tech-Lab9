class Appointment < ApplicationRecord
  belongs_to :pet
  belongs_to :vet
  has_many :treatments

  # Enum
  enum :status, { scheduled: 0, in_progress: 1, completed: 2, cancelled: 3 }

  # Validations
  validates :date, presence: true
  validates :reason, presence: true
  validates :status, presence: true

  # Scopes
  scope :upcoming, -> { where("date > ?", Time.now).order(date: :asc) }
  scope :past, -> { where("date < ?", Time.now).order(date: :desc) }
end