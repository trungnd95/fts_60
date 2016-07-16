class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?

  include CanCan::ControllerAdditions
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up do |u|
      u.permit :name, :email, :password, :password_confirmation, :remember_me
    end
  end

  def check_if_admin
    if user_signed_in?
      unless current_user.admin?
        flash[:warning] = t "page.admin.flash.admin_only"
        redirect_to root_path
      end
    else
      flash[:danger] = t "page.admin.flash.please_login"
      redirect_to root_path
    end
  end
end
