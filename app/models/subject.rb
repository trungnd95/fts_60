class Subject < ActiveRecord::Base
  has_many :examinations, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: true}
  validates :description, presence: true
  validates :question_number, presence: true, numericality: true
  validates :duration, presence: true, numericality: true
end
