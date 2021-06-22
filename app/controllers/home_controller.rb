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
    @broker = User.find(params[:id])

    if @broker
      @broker.update(approved: true)
      UserMailer.with(email: @broker.email).admin_approved_email.deliver_now
      @broker.save
      redirect_to root_path, notice: 'Broker approved'
    else
      redirect_to root_path, notice: 'Broker not approved'
    end
  end

  def update_buyer
    @user = User.find(params[:broker][:id])
    if @user.update(email: params[:broker][:email], first_name: params[:broker][:first_name], last_name: params[:broker][:last_name])
      redirect_to root_path, notice: "updated na po sya"
    else
      redirect_to root_path, notice: "hindi sya updated tanga"
    end
  end
end