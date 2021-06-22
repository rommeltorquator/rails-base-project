require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  before do
    @user = User.create(id: 100, email: 'test1@email.com', created_at: '2021-06-21 10:25:00', updated_at: '2021-06-21 10:25:00', first_name: nil, last_name: nil, type: nil)

    @portfolio = Stock.create(id: 101, name: 'Apple', symbol: 'AAPL', current_price: '130.46', created_at: '2021-06-21 10:30:00', updated_at: '2021-06-21 10:30:00', user_id: 100)
  end

  let(:user) { User.new }

  let(:portfolio) { Stock.new }

  it 'checks if portfolio can be created' do
    expect(:portfolio).to be_present
  end
end
