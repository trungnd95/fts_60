class Question < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :answers, dependent: :destroy
  has_many :results, dependent: :destroy
end
