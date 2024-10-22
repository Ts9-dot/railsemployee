# app/controllers/admins_controller.rb
class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def dashboard
    @employees = Employee.all
    @recent_employees = Employee.order(created_at: :desc).limit(10) # Fetch recent employees
    @total_employees = Employee.count # Count total employees
    @total_users = User.count # Count total users (assuming you have a User model)
  end

  private

  def ensure_admin
    redirect_to root_path, alert: "Access denied." unless current_user.admin?
  end
end
