class StocksController < ApplicationController
  # before_action :authenticate_broker!, except: [:index]
  # before_action :authenticate_buyer!, except: [:index]
  before_action :fetch_api, only: %i[index show create watch unwatch]

  def index; end

  def show
    @stock = @client.quote(params[:id].to_s)
    @brokers = User.where(type: 'Broker')
    @buyer_stock = BuyerStock.new
  end

  # broker stocks
  def create
    @stock_symbols = ['tae']
    @quote = @client.quote(params[:id].to_s)
    @portfolio = Stock.create(name: @quote.company_name.to_s, symbol: @quote.symbol.to_s, current_price: @quote.latest_price, user_id: current_broker.id)

    redirect_to stocks_path, notice: 'Stock has been successfully added to your portfolio' if @portfolio.save
  end

  # buyer stocks
  def add_stock
    @buyer = current_buyer.buyer_stocks.find_by(stockSymbol: params[:stock_symbol])
    @watched_stock = WatchedStock.find_by(symbol: params[:stock_symbol])
    @watched_stock.destroy
    if @buyer.nil?
      @buyer_stock = BuyerStock.new(user_id: current_buyer.id, price: params[:price], quantity: params[:quantity], broker_email: params[:broker_email].to_s, stockSymbol: params[:stock_symbol].to_s)
      if @buyer_stock.save
        @transaction = PurchaseTransaction.new(
          stock_code: params[:stock_symbol],
          company_name: params[:company_name],
          price: params[:price],
          volume: params[:quantity],
          total_value: params[:price].to_i * params[:quantity].to_i,
          user_id: current_buyer.id,
          broker_id: params[:broker_id],
          stock_id: params[:stock_id],
          broker_name: params[:broker_email]
        )
        @transaction.save
        redirect_to stocks_path, notice: 'Stock was successfully added'
      else
        redirect_to stocks_path, notice: 'It is not fucking working'
      end
    else
      @buyer.quantity += params[:quantity].to_i
      @buyer.save
      redirect_to stocks_path, notice: 'Stock was successfully updated'
    end
  end

  # broker stock
  def destroy
    @stock = Stock.find(params[:id])
    redirect_to portfolio_home_index_path, notice: 'Stock has been successfully removed' if @stock.destroy
  end

  # buyer stock
  def destroy_buyer_stock
    @stock = BuyerStock.find(params[:id])
    if @stock.destroy
      redirect_to portfolio_home_index_path, notice: 'Buyer stock has been sold'
    else
      redirect_to portfolio_home_index_path
    end
  end

  def watch
    @stock = @client.quote(params[:symbol].to_s)
    @watched_stock = WatchedStock.new(buyer_id: current_buyer.id, symbol: @stock.symbol, avg_total_volume: @stock.avg_total_volume, latest_price: @stock.latest_price, company: @stock.company_name, change_percent_s: @stock.change_percent_s)

    @watched_stock.save
    redirect_to root_path, notice: 'Stock has been added to watch list'
  end

  def unwatch
    @watched_stock = WatchedStock.find_by(symbol: params[:symbol])
    @watched_stock.destroy
    redirect_to stocks_path, notice: 'You have unfollowed a stock'
  end

  private

  def fetch_api
    @client = IEX::Api::Client.new(
      publishable_token: ENV['PUBLIC'],
      secret_token: ENV['SECRET'],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
  end
end
