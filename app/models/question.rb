class Question < ActiveRecord::Base
  include PublicActivity::Model

  belongs_to :user
  belongs_to :subject
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  tracked  owner: ->(controller, model){controller && controller.current_user}

  enum question_type: [:single_choise, :multiple_choise, :text]
  enum question_status: [:pending, :accepted, :reject]

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :content, presence: true, length: {minimum: 2},
    uniqueness: {case_sensitive: true}
  validates :subject_id, presence: true
  validates_associated  :answers
  validate :validate_answers_if_choosen

  scope :suggest, ->{where.not(user_id: nil).where(question_status: 0)}
  scope :accepted_question, ->{where(question_status: 1)}
  scope :accepted, -> {where question_status: 0}

  private
  def validate_answers_if_choosen
    unless self.text?
      if answers.size <= 1
        errors.add(:answer, I18n.t("page.admin.questions.answers.validate.number_answers"))
      end
      if answers.reject{|answer| !answer.correct?}.count == 0
        errors.add(:correct_answers, I18n.t("page.admin.questions.answers.validate.number_correct"))
      end
    end
  end
end
