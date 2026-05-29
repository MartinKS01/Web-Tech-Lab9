class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  enum :role, { owner: 0, vet: 1, admin: 2 }

  validates :first_name, presence: true
  validates :last_name, presence: true

  has_one :owner_record, class_name: "Owner", foreign_key: :user_id
  has_one :vet_record, class_name: "Vet", foreign_key: :user_id

  def full_name
    "#{first_name} #{last_name}"
  end
end