class Buyer < User
  before_create :approved_email
  after_create :create_account
  has_many :watched_stocks, dependent: :nullify
  has_one :cash, dependent: :destroy

  private

  def approved_email
    UserMailer.with(email: email).buyer_account_created.deliver_now
  end

  def create_account
    Cash.create!(buyer_id: id, amount: 0)
  end
end
