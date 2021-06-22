class Broker < User
  before_create :unapprove_broker
  before_create :pending_approval_notification

  private

  def unapprove_broker
    self.approved = false
  end

  def pending_approval_notification
    UserMailer.with(email: email).pending_approval_email.deliver_now
  end
end
