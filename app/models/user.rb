class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[admin employee]

  validates :role, inclusion: { in: ROLES }, presence: true

  has_one :employee  # Assuming a user has one employee profile

  def can_view_employee?(employee)
    return false if employee.nil? # Prevents NoMethodError
    self.id == employee.user_id
  end


  def admin?
    self.role == "admin"
  end

  def employee?
    self.role == "employee"
  end
end
