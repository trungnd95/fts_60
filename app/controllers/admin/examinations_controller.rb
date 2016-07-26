class Admin::ExaminationsController < ApplicationController
  layout "admin"
  load_and_authorize_resource

  def index
    @examinations = Examination.includes([:subject, :user]).page(params[:page])
      .per Settings.per_page
  end

  def update
    respond_to do |format|
      if @examination.update_attributes examination_params
        EmailResultWorker.perform_async examination_params[:id]
        format.html do
          flash[:success] = t "page.admin.exams.update.success"
          redirect_to @examination
        end
        @score = "#{@examination.results.is_corrects.count} /
          #{@examination.subject.question_number}"
        format.json do
          render json: {id: examination_params[:id], status: @examination.status,
            score: @score}
        end
      else
        format.html do
          flash[:fail] = t "page.admin.exams.update.success"
          redirect_to :back
        end
        format.json{render json: @examination.errors, status: :unprocessable_entity}
      end
    end
  end

  private
  def examination_params
    params.require(:examination).permit :id, :status, :user_id, :subject_id
  end
end
