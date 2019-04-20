class ApplicationController < ActionController::Base

	before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(devise)
    '/dashboard'
  end

  def after_sign_out_path_for(devise)
    '/'
  end

  protected

    def authenticate_editor!
      redirect_to root_path unless user_signed_in? && current_user.is_editor_user?
    end

    def authenticate_admin!
      redirect_to root_path unless user_signed_in? && current_user.is_admin_user?
    end
    
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    end



end
