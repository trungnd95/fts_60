class EmailResultWorker
  include Sidekiq::Worker

  def perform exam_id
    exam = Examination.find exam_id
    UserNotificationMailer.send_exam_result(exam).deliver
  end
end
