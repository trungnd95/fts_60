class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy

  enum question_type: [:single_choise, :multiple_choise, :text]
  enum question_status: [:pending, :accepted, :reject]

  accepts_nested_attributes_for :answers, allow_destroy: true

  validates :content, presence: true, length: {minimum: 2}
  validates :subject_id, presence: true
  validates_associated  :answers

  validate :validate_answers_if_choosen

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
