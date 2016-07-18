class Result < ActiveRecord::Base
  belongs_to :question
  belongs_to :examination
  belongs_to :answer

  scope :is_corrects, -> do
    joins(:answer).where answers: {correct: true}
  end
end
