class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params_sign_up|
      user_params_sign_up.permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)

    end
  end


end
