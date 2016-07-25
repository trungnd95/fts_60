class UsersController < ApplicationController
  load_and_authorize_resource

  def update
    if @user.update_attributes user_params
      flash[:update_success] = t "views.devise.users.update"
      redirect_to user_path current_user
    else
      render :edit
    end
  end

  def show
    @activities = PublicActivity::Activity.order(created_at: :desc)
      .page(params[:page]).per Settings.per_page
  end

  private
  def user_params
    params.require(:user).permit :name, :avatar, :email
  end
end
