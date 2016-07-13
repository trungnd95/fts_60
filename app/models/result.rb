class Result < ActiveRecord::Base
  belongs_to :question
  belongs_to :examination
  belongs_to :answer
end
