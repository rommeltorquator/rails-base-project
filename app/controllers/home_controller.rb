class HomeController < ApplicationController
  def index
    @hope = 'Hope is the anchor of the soul'
    @brokers = User.where(type: 'Broker')
    @buyers = User.where(type: 'Buyer')
    @pending_approval = User.where(approved: false)
    @transactions = PurchaseTransaction.all
  end

  def portfolio; end

  def transaction
    @transactions = if current_buyer
                      current_buyer.purchase_transactions
                    elsif current_broker
                      PurchaseTransaction.where(broker_id: current_broker.id)
                    elsif current_admin
                      PurchaseTransaction.all
                    end
  end

  def show_user
    @user = User.find(params[:id])
  end

  def approve
    @broker = User.find(params[:broker])

    if @broker
      @broker.update(approved: true)
      @broker.save
      redirect_to root_path, notice: 'Broker approved'
    else
      redirect_to root_path, notice: 'Broker not approved'
    end
  end
end
