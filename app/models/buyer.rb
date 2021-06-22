class Buyer < User
  before_create :approved_email

  private

  def approved_email
    UserMailer.with(email: email).buyer_account_created.deliver_now
  end
end