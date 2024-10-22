class ApplicationController < ActionController::Base
  # before_action :ensure_admin
  # before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  private

  def ensure_admin
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied."
    end
  end


  def after_sign_out_path_for(resource_or_scope)
    root_path # Redirect to home page
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :role ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :role ])
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_dashboard_path
    else
      employee_dashboard_path
    end
  end
end
