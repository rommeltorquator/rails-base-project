class Stock < ApplicationRecord
  belongs_to :user
  has_many :purchase_transactions, dependent: :nullify
end
