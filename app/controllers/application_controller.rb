class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit :name, :email, :password, :password_confirmation, :remember_me

  def check_if_admin
    if user_signed_in?
      unless current_user.admin?
        flash[:warning] = t "page.admin.flash.admin_only"
        redirect :back
      end
    else
      flash[:danger] = t "page.admin.flash.please_login"
      redirect :back
    end
  end
end
