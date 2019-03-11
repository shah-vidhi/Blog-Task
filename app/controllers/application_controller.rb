class ApplicationController < ActionController::Base
	before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
    format.json { head :forbidden, content_type: 'text/html' }
    format.html { redirect_to main_app.blogs_path, notice: exception.message }
    format.js { head :forbidden, content_type: 'text/html' }
    end
  end
  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :contact, :avatar, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

   def after_sign_in_path_for(resource)
    home_show_path
   end
end
