class Examination < ActiveRecord::Base
  enum status: [:start, :testing, :uncheck, :checked]
  after_initialize :default_spent_time

  belongs_to :subject
  belongs_to :user
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results,
    reject_if: lambda {|a| a[:question_id].blank?}, allow_destroy: true

  after_create :create_results

  delegate :name, :duration, :question_number, to: :subject,
    prefix: true, allow_nil: true

  scope :examination_user, ->(current_user){where(user_id: current_user.id)}

  def create_results
    questions = subject.questions.order("RANDOM()").take subject.question_number
    questions.each{|question| Result.create(question_id: question.id,
      examination_id: self.id)}
  end

  def default_spent_time
    self.created_at ||= Settings.default_spent_time
  end
end
