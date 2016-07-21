class ExaminationsController < ApplicationController
  load_and_authorize_resource

  def index
    @subjects = Subject.all
    @exam = Examination.new
  end

  def create
    respond_to do |format|
      if @examination.save examination_params
        format.html{
          flash[:success] = t "page.views.devise.examination.controller.create"
          redirect_to examinations_path
        }
      else
        format.html{
          render :new
        }
      end
    end
  end

  private
  def examination_params
    params.require(:examination).permit :subject_id, :status, :user_id
  end
end
