class MyTransactionDetailController < ApplicationController
  def index
    @cart_count = Cart.where(:user_id => session[:user_id]).count
    if session[:user_id]
      @current_user = User.find(session["user_id"])
      puts session[:user_id]
      @my_transaction_detail = MyPayment.find(params[:id])
      @my_orders = MyOrder.where(:my_payment_id => params[:id])
    else
      @current_user = nil
    end
  end
end
