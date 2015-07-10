class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #action that has to be performed before serving any page
  before_action :authenticate_user!

      # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    

    before_filter :configure_permitted_parameters, if: :devise_controller?


    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation, :image ) }
            devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:firstname, :lastname, :email, :password, :password_confirmation,:current_password, :image ) }
        end
end
