class Admin::ExaminationsController < ApplicationController
  load_and_authorize_resource

  def index
    @exams = Examination.includes([:subject, :user]).page(params[:page])
      .per Settings.per_page
  end

  def update
  end
end
