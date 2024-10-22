module Admin
  class ReportsController < ApplicationController
    before_action :ensure_admin
    def index
      @employee_count = Employee.group_by_day(:created_at).count
    end


    def show
      @report = Report.find(params[:id])
      respond_to do |format|
        format.html # Renders HTML by default
        format.pdf do
          render pdf: "report_#{@report.id}", # The name of the PDF file
                 template: "admin/reports/show", # Path to the template
                 layout: "pdf", # Optional: specify a layout for the PDF
                 formats: [ :html ] # Ensures that the template is rendered as HTML before being converted to PDF
        end
      end
    end


    private

    def ensure_admin
      unless current_user&.admin? # Assuming you have a current_user method
        redirect_to root_path, alert: "Access denied."
      end
    end

    def download_pdf
      @employees = Employee.all
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: "Employee_Report", template: "admin/reports/pdf", formats: [ :html ]
        end
      end
    end
  end
end
