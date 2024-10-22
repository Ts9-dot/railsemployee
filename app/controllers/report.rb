# app/controllers/admin/reports_controller.rb
class Admin::ReportsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin

  def index
    # Logic to display reports
  end
end
