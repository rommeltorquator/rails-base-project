class PurchaseTransaction < ApplicationRecord
  belongs_to :user
  belongs_to :broker

  def self.total_brokered_deal
    sum(:total_value)
  end
end
