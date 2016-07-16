class Admin::SubjectsController < ApplicationController
  layout "admin"
  before_action :check_if_admin
  load_and_authorize_resource
  skip_authorize_resource only: [:index, :create]

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

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    respond_to do |format|
      if @subject.save
        UserNotificationService.new(User.normal_user).notify(@subject)
        format.html do
          flash[:success] = t "page.admin.subjects.create.success"
          redirect_to admin_subjects_path
        end
        format.json{render json: @subject, status: :created}
      else
        format.html{render action: :new}
        format.json{render json: @subject.errors, status: :unprocessable_entity}
      end
      format.js
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description, :question_number,
      :duration
  end
end
