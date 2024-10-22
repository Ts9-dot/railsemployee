class Employee < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, presence: true
  validates :email, presence: true,  format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :position, presence: true
  validates :department, presence: true
end
