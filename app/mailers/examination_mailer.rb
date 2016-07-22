class ExaminationMailer < ApplicationMailer
  def notify_delay examination
    @examination = examination
    @user = examination.user
    mail to: @user.email,
      subject: t("page.views.devise.mailer.rexamination_delay")
  end
end
