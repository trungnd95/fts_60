class Examination < ActiveRecord::Base
  enum status: [:start, :testing, :check, :uncheck]
  after_initialize :default_status, :default_spent_time

  belongs_to :subject
  belongs_to :user
  has_many :results, dependent: :destroy

  before_create :create_questions_examination

  delegate :name, :duration, :question_number, to: :subject,
    prefix: true, allow_nil: true

  private
  def create_questions_examinationon
    self.questions = self.subject.questions.order("RANDOM()")
      .limit Settings.number_questions_per_examination
  end

  def default_status
    self.status ||= "start"
  end

  def default_spent_time
    self.created_at ||= Settings.default_spent_time
  end

end
