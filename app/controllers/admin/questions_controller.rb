class Admin::QuestionsController < ApplicationController
  layout "admin"
  before_action :check_if_admin
  load_and_authorize_resource except: [:create, :index]

  def index
    @subjects =  Subject.all
    @questions =  Question.includes([:subject, :answers])
      .page(params[:page]).per Settings.per_page
    @question =  Question.new
    @question.answers.new

    respond_to do |format|
      if @questions.size > 0
        format.html
        format.json{render json: @questions}
      else
        format.html
        format.json{head :no_content}
      end
    end
  end

  def create
    @question = Question.new question_params
    respond_to do |format|
      if @question.save
        format.html do
          flash[:success] = t "page.admin.questions.add.success"
          redirect_to admin_questions_path
        end
        format.json do
          render json: {
            content: render_to_string({
              partial: "admin/questions/question",
              locals: {question: @question},
              formats: "html",
              layout: false
            })
          }
        end
      else
        format.html do
          flash[:danger] = t "page.admin.words.add.danger"
          render action: :index
        end
        format.json{render json: @question.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def question_params
    params.require(:question).permit(:id, :content, :question_status,
      :question_type, :subject_id,
      answers_attributes: [:id, :content, :correct, :question_id])
  end
end
