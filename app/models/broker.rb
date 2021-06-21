class Broker < User
  before_create :unapprove_broker

  private
  def unapprove_broker
    self.approved = false
  end
end
