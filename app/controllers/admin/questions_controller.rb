class Admin::QuestionsController < ApplicationController
  layout "admin"
  before_action :check_if_admin
  load_and_authorize_resource except: [:create, :index]
  before_action :load_subjects, except: [:new, :delete]

  def index
    if params[:suggest_question]
      @questions  = Question.includes([:subject, :answers])
        .suggest.order(created_at: :desc).page(params[:page]).per Settings.per_page
      respond_to do |format|
        format.html do
          render template: "admin/questions/suggest_question"
        end
        format.json{render json: @questions, status: :ok}
      end
    else
      @questions =  Question.includes([:subject, :answers])
        .accepted_question.order(created_at: :desc)
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
              locals: {question: @question, subjects: @subjects},
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

  def edit
  end

  def update
    respond_to do |format|
      if @question.update question_params
        format.html do
          flash[:success] =  t "page.admin.questions.edit.success"
          redirect_to admin_questions_path
        end
        format.json do
          render json:  {
            message: t("page.admin.questions.update.success"),
            question_id: params[:id],
            content: render_to_string({
              partial: "admin/questions/question",
              formats: "html",
              locals: {question: @question, subjects: @subjects},
              layout: false
            })
          }
        end
      else
        format.html do
          flash[:danger] =  t "page.admin.questions.edit.fail"
          redirect_to :back
        end
        format.json{render json: @question.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @question.results.count > 0
        @message = t "page.admin.questions.destroy.fail"
        format.html do
          flash[:warning] =  @message
          redirect_to :back
        end
        format.json do
          render json: {warning: {message: @message}}
        end
      else
        @question.destroy
        format.html do
          redirect_to admin_questions_path,
            success: t("page.admin.questions.destroy.success")
        end
        format.json do
          render json: {id: params[:id], status: :ok}
        end
      end
    end
  end

  private
  def question_params
    params.require(:question).permit :id, :content, :question_status,
      :question_type, :subject_id,
      answers_attributes: [:id, :content, :correct, :question_id]
  end

  def load_subjects
    @subjects =  Subject.all
  end
end
