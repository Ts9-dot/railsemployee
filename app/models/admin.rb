# app/models/admin.rb
class Admin < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :position, presence: true
  validates :department, presence: true
  validates :phone_number, presence: true
  validates :date_of_birth, presence: true
  validates :salary, presence: true, uniqueness:  true
  validates :user_id, presence: true, uniqueness: true
end
