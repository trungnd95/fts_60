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

  def edit
  end

  def update
    respond_to do |format|
      if @subject.update subject_params
        format.html do
          flash[:success] = t "page.admin.subjects.edit.success"
          redirect_to admin_subjects_path
        end
        format.json{render json: @subject , status: :ok}
      else
        format.html do
          flash[:danger] = t "page.admin.subjects.edit.fail"
          render action: :edit
        end
        format.json{render json: @subject.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @subject.examinations.count > 0
        @message = t "page.admin.subjects.destroy.fail"
        format.html do
          flash[:warning] =  @message
          redirect_to :back
        end
        format.json do
          render json: {warning: {message: @message}}
        end
      else
        @subject.destroy
        format.html do
          redirect_to admin_subjects_path,
           success: t("page.admin.subjects.destroy.success")
        end
        format.json do
          render json: {id: params[:id], status: :ok}
        end
      end
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description, :question_number,
      :duration
  end
end
