class Admin::ExamSerializer < ActiveModel::Serializer
  attributes :id, :status, :user_id, :subject_id,
    :created_at, :updated_at
end
