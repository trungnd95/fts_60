class Answer < ActiveRecord::Base
  belongs_to :question
  validates :content, presence: true

  scope :number_correct, ->{where(correct: true).count}
end
