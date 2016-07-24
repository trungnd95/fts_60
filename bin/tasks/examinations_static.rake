namespace :examinations_static do
  desc "Send static page examinations every month"
  task send: :environment do
    Examination.send_static_exams
  end
end
