class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  alias_method :devise_current_user, :current_user


  # Returns a User or a GuestUser instance, wether or not the current resource
  # is authenticated.
  #
  # @return [User, GuestUser]
  def current_user
    # Returns the current User instance when it is authenticated through Devise
    if user = devise_current_user
      # Convenient way to query the current_user for authenticated-ness
      user.authenticated = true
      user
    else
      GuestUser.new
    end
  end

  # Ensure a User cannot access an action unless being signed out
  def require_no_authentication
    if current_user.authenticated?
      flash[:alert] = I18n.t('devise.failure.already_authenticated')
      redirect_to after_sign_in_path_for(current_user)
    end
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation) }
  end
end
