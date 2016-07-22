class Users::SessionsController < Devise::SessionsController
  before_action :create_log, except: :new

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end

  def create_log
    if params[:commit] == t("page.admin.log_in")
      content = "#{current_user.name} #{t("page.admin.has_been_sign_in")} \n"
    else
      content = "#{current_user.name} #{t("page.admin.has_been_sign_out")} \n"
    end
    CUSTOM_LOGGER.info content
  end
end
