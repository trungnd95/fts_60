class QuestionsController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource only: :index
  before_action :load_subjects

  def index
    @questions = Question.where(user_id: current_user.id).page(params[:page])
      .per Settings.per_page
  end

  def new
    @question = Question.new
    @question.answers.new
  end

  def create
    @question = current_user.questions.new question_params
    respond_to do |format|
      if @question.save
        format.html do
          flash[:success] = t "page.admin.questions.add.success"
          redirect_to questions_path
        end
        format.json{render json: @question, status: :created}
      else
        format.html do
          flash[:danger] = t "page.admin.questions.add.danger"
          render action: :new
        end
        format.json{render json: @question.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :question_status,
      :question_type, :subject_id, :user_id,
      answers_attributes: [:id, :content, :correct, :question_id]
  end

  def load_subjects
    @subjects =  Subject.all
  end
end
