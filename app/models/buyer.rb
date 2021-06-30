class Buyer < User
  before_create :approved_email
  has_many :watched_stocks  

  private

  def approved_email
    UserMailer.with(email: email).buyer_account_created.deliver_now
  end
end
