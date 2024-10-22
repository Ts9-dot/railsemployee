class Admin::EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :set_employee, only: [ :show, :edit, :update, :destroy ]

  def index
    @employees = Employee.all
  end
  def show
    @employee = Employee.find_by(user_id: current_user.id) # Assuming current_user is the logged-in user
  end

  def new
    @employee = Admin.new
  end

  def create
    @employee = Admin.new(employee_params)
    if @employee.save
      redirect_to admin_dashboard_path, notice: "Employee was successfully created."
    else
      puts @employee.errors.full_messages # This will print validation errors to the console
      render :show
    end
  end


  def edit
    @employee = Employee.find_by(id: params[:id])
    Rails.logger.debug "Parameters: #{params.inspect}"
    Rails.logger.debug "Employee: #{@employee.inspect}"
    if @employee.nil?
      redirect_to employees_path, alert: "Employee not found."
    end
  end


  def update
    if @employee.update(employee_params)
      redirect_to admin_employee_path(@employee), notice: "Employee was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @employee.destroy
    redirect_to admin_employees_path, notice: "Employee was successfully deleted."
  end

  def dashboard
    @employee = Employee.find_by(user_id: current_user.id)

    if @employee.nil?
      flash[:alert] = "Employee details not found."
      redirect_to root_path # Redirect if employee not found
    end
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])
    if @employee.nil?
      redirect_to admin_employees_path, notice: "Employee not found"
    end
  end

  def employee_params
    params.require(:employee).permit(:name, :email, :position) # Adjust permitted params as necessary
  end

  def authorize_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
  def employee_params
    params.require(:admin).permit(:name, :email, :position, :department, :phone_number, :date_of_birth, :salary, :user_id)
  end
end
