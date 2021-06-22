# require 'rails_helper'

# RSpec.describe Stock, type: :model do
#   before do
#     @user = User.create(id: 100, email: 'test1@email.com', created_at: '2021-06-21 10:25:00', updated_at: '2021-06-21 10:25:00', first_name: nil, last_name: nil, type: nil)

#     @portfolio = described_class.create(name: 'Apple', symbol: 'AAPL', current_price: '130.46', created_at: '2021-06-21 10:30:00', updated_at: '2021-06-21 10:30:00', user_id: 100)
#   end

#   let(:user) { User.new }

#   let(:portfolio) { described_class.new }
#   let(:quote) { Client.quote(params[:id]) }

#   it 'checks if portfolio can be created' do
#     expect(:portfolio, :quote).to be_valid
#   end

#   it 'checks if a portfolio can be read or viewed' do
#     expect(described_class.find(name: 'Apple')).to equal?(:id)
#   end

#   it 'checks if a portfolio can be updated' do
#     :portfolio.update(name: 'Apple Inc.')
#     expect(described_class.find(name: 'Apple')).to equal?(:portfolio)
#   end

#   it 'checks that a portfolio can be destroyed' do
#     :portfolio.destroy
#     expect(described_class.count).to equal?(0)
#   end
# end
