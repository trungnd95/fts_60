class Answer < ActiveRecord::Base
  belongs_to :question
  has_many :results

  validates :content, presence: true
end
