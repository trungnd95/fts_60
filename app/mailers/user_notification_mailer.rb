class UserNotificationMailer < ApplicationMailer
  default  from: Settings.default_email
  def send_notify user, subject
    @subject = subject
    @user =  user
    mail to: @user.email, subject: t("page.admin.subjects.email.subject")
  end

  def send_exam_result exam
    @exam = exam
    @user = exam.user
    mail to: @user.email, subject: t("page.admin.exams.email.result.subject")
  end

  def send_static_every_month exams, user
    @exams = exams
    @user = user
    mail to: @user.email, subject: t("page.admin.exams.email.static.subject")
  end
end
