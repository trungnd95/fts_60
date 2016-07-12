class User < ActiveRecord::Base
  has_many :examinations, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :questions, depandent: :destroy
end
