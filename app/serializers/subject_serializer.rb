class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :question_number,
    :duration, :url
  has_many :examinations
  has_many :questions

  def url
    subject_url(object)
  end
end
