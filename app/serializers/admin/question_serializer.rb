class Admin::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :content, :question_status, :question_type, :url
  has_many :answers

  def url
    {self: admin_question_path(object.id)}
  end
end
