class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :check_if_admin
  load_and_authorize_resource

  def index
    @users =  User.order(created_at: :desc).page(params[:page])
     .per Settings.per_page

  def destroy
    if @user.destroy
      flash[:success] = t "page.admin.users.success"
    else
      flash[:danger] = t "page.admin.users.default"
    end
    redirect_to admin_users_path
  end
end
