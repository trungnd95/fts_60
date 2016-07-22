class ExaminationDelay
  def send_email_delay_examination
    ExaminationMailer.notify_delay(self).deliver_now
  end

  handle_asynchronously :send_email_delay_examination,
    run_at: Proc.new {8.hours.from_now}
end
