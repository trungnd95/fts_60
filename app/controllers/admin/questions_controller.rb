class Admin::QuestionsController < ApplicationController
  layout "admin"
  before_action :check_if_admin
  load_and_authorize_resource
  skip_authorize_resource only: [:index, :create]

  def index
    @questions =  Question.includes([:subject, :answers])
      .page(params[:page]).per Settings.per_page
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

  private
  def admin_question_params
    params.require(:question).permit :content, :question_status, :question_type,
     :user_id, :subject_id
  end
end
