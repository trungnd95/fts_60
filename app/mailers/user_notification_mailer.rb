class UserNotificationMailer < ApplicationMailer
  default  from: Settings.default_email
  def send_notify user, subject
    @subject = subject
    @user =  user
    mail to: @user.email, subject: t("page.admin.subjects.email.subject")
  end
end
