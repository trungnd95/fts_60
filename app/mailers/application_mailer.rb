class ApplicationMailer < ActionMailer::Base
  default from: Settings.default_email1
  layout "mailer"
end
