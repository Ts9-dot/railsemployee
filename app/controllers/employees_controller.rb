class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: [ :show ]
  before_action :authorize_user!, only: [ :show ]

  def index
    @employees = Employee.all
  end
  def new
    @employee = Admin.new
  end

  def create
    @employee = Admin.new(employee_params)
    if @employee.save
      redirect_to admin_dashboard_path, notice: "Employee was successfully created."
    else
      render :new  # This renders the form again if there are validation errors
    end
  end

  def show
    @employee = Employee.find_by(user_id: params[:user_id], name: params[:name])

    if @employee.nil?
      redirect_to root_path, alert: "Employee not found."
    else
      authorize_user!
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

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to employees_path, notice: "Employee was successfully deleted."
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update(employee_params)
      redirect_to employee_path(@employee), notice: "Employee was successfully updated."
    else
      render :edit
    end
  end

  def dashboard
    @employee = current_user.employee
  end

  # def report
  #   @employees = Employee.all

  #   respond_to do |format|
  #     format.html
  #     format.pdf do
  #       pdf = Prawn::Document.new
  #       pdf.text "Employee Report"
  #       @employees.each do |employee|
  #         pdf.text "#{employee.name}, #{employee.position}, #{employee.email}, #{employee.salary}"
  #       end
  #       send_data pdf.render, filename: "Employee_Report.pdf", type: "application/pdf"
  #     end
  #   end
  # end

  # def find_employee
  #   @employee = Employee.find_by(name: params[:name], email: params[:email])

  #   if @employee
  #     respond_to do |format|
  #       format.html
  #       format.pdf do
  #         pdf = Prawn::Document.new
  #         pdf.text "Employee Report"
  #         pdf.text "Name: #{@employee.name}"
  #         pdf.text "Email: #{@employee.email}"
  #         pdf.text "Position: #{@employee.position}"
  #         pdf.text "Department: #{@employee.department}"
  #         send_data pdf.render, filename: "employee_report.pdf",
  #                               type: "application/pdf",
  #                               disposition: "inline"
  #       end
  #     end
  #   else
  #     flash[:alert] = "Employee not found."
  #     redirect_to find_employee_employees_path
  #   end
  # end



  private

  def set_employee
    @employee = Employee.find_by(user_id: params[:user_id], name: params[:name])
  end

  def authorize_user!
    # Allow only the employee or an admin to view the details
    unless current_user.admin? || current_user.id == @employee.user_id
      redirect_to root_path, alert: "You are not authorized to view this employee."
    end
  end


  def employee_params
    params.require(:admin).permit(:name, :email, :phone_number, :address, :date_of_birth, :salary, :position, :department, :user_id)
  end
end
