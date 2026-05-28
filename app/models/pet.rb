class Pet < ApplicationRecord
  belongs_to :owner
  has_many :appointments

  has_one_attached :photo

  SPECIES = %w[dog cat rabbit bird reptile other].freeze

  validates :name, presence: true
  validates :species, presence: true, inclusion: { in: SPECIES }
  validates :date_of_birth, presence: true
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validate :date_of_birth_cannot_be_in_the_future
  validate :acceptable_photo

  scope :by_species, ->(species) { where(species: species.downcase) }

  before_save :capitalize_name

  private

  def capitalize_name
    self.name = name.capitalize if name.present?
  end

  def date_of_birth_cannot_be_in_the_future
    if date_of_birth.present? && date_of_birth > Date.today
      errors.add(:date_of_birth, "cannot be in the future")
    end
  end

  def acceptable_photo
    return unless photo.attached?

    unless photo.blob.content_type.in?(%w[image/jpeg image/png image/webp])
      errors.add(:photo, "must be a JPEG, PNG, or WebP image")
    end

    if photo.blob.byte_size > 5.megabytes
      errors.add(:photo, "must be less than 5MB in size")
    end
  end
end