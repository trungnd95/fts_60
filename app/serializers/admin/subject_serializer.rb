class Admin::SubjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :question_number,
    :duration, :url
  has_many :examinations
  has_many :questions

  def url
    {self: admin_subject_path(object.id)}
  end
end
