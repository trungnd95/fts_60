# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
5.times do |u|
  User.create! name: "User" + (u+1).to_s,
  email: "user#{u+1}@gmail.com",
  password: "123456"
end

5.times do |u|
  Subject.create! name: "Git" + (u+1).to_s,
  description: "abc",
  question_number: 20,
  duration: 30
end

5.times do |u|
  Examination.create! status: 1,
  user_id: 1,
  subject_id: (u+1)
end

5.times do |u|
  Question.create! content: "abc",
  question_status: 1,
  question_type: 1,
  user_id: 1,
  subject_id: 1
end
