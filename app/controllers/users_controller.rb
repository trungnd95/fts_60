class UsersController < ApplicationController
  load_and_authorize_resource

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:update_success] = t "page.views.devise.users.update"
      redirect_to user_path current_user
    else
      render :edit
    end
  end

  def show
    @activities = PublicActivity::Activity.where(owner_id: current_user.id)
      .order(created_at: :desc).page(params[:page]).per Settings.per_page
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :avatar
  end
end
