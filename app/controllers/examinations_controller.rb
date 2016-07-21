class ExaminationsController < ApplicationController
  load_and_authorize_resource
  before_action :check_exam_of_current_user

  def index
    @subjects = Subject.all
    @exam = Examination.new
    @examinations = Examination.examination_user(current_user)
      .order(created_at: :desc).page(params[:page]).per Settings.per_page
  end

  def show
    if @examination.start?
      @examination.update_attributes  status: :testing
    end
  end

  def update
    if @examination.update_attributes examination_params
      redirect_to examinations_path
      flash[:success] = t "category.lesson.save_success"
    else
      flash[:danger] = t "category.lesson.save_fail"
      redirect_to :back
    end
  end

  def create
    @exam = current_user.examinations.build examination_params
    respond_to do |format|
      if @exam.save examination_params
        format.html do
          flash[:success] = t "page.views.devise.examination.controller.create"
          redirect_to examinations_path
        end
      else
        format.html{
          render :new
        }
      end
    end
  end

  private
  def examination_params
    params.require(:examination).permit :subject_id, :status, :user_id,
      results_attributes: [:id, :examination_id, :question_id, :answer_id]
  end

  def check_exam_of_current_user
    if params[:id].present?
      if current_user.examinations.find_by(id: params[:id]).nil?
        flash[:danger] = t "page.views.devise.examination.controller.check_exam"
        redirect_to examinations_path
      end
    end
  end
end
