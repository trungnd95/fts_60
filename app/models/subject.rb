class Subject < ActiveRecord::Base
  has_many :examinations, dependent: :destroy
  has_many :questions, dependent: :destroy
end
