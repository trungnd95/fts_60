class Subject < ActiveRecord::Base
  acts_as_paranoid

  has_many :examinations, dependent: :destroy
  has_many :questions, dependent: :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: true},
    length: { minimum: 3, maximum: 30 }
  validates :description, presence: true
  validates :question_number, presence: true,
    numericality: {only_integer: true, greater_than: 3}
  validates :duration, presence: true, numericality: true
end
