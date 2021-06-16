class Stock < ApplicationRecord
  has_many :broker_stocks, dependent: :destroy
end
