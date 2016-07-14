class Admin::SubjectsController < ApplicationController
  layout "admin"
  before_action :check_if_admin
  def index
    @subjects =  Subject.page(params[:page]).per Settings.per_page
    respond_to do |format|
      if @subjects.size > 0
        format.html
        format.json{render json: @subjects}
      else
        format.html
        format.json do
          render json: [t("page.admin.no-content.title") => t("page.admin.no-content.title")]
        end
      end
    end
  end
end
