class UserNotificationService
  def initialize users
    @users  = users
  end

  def notify subject
    @users.each do |user|
      UserNotificationMailer.send_notify(user, subject).deliver
    end
  end
end
