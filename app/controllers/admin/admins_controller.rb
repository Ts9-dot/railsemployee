module Admin
  class AdminsController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_admin

    # Admin dashboard with recent employees data
    def dashboard
      @recent_employees = Employee.order(created_at: :desc).limit(10)
      @total_employees = Employee.count
      @total_users = User.count
    end

    # Employees list
    def index
      @employees = Employee.all
      @total_employees = Employee.count
      @total_users = User.count
      @recent_employees = Employee.order(created_at: :desc).limit(5)
    end

    # Show a single employee
    def show
      @employee = Employee.find(params[:id])
    end

    private

    # Ensure the user is an admin
    def ensure_admin
      redirect_to root_path, alert: "Access denied." unless current_user.admin?
    end
  end
end
