class Admin::UsersController < ApplicationController
  layout "admin"
  before_action :check_if_admin
  load_and_authorize_resource

  def index
    @users =  User.order(created_at: :desc).page(params[:page]).per Settings.per_page
  end
end
