class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :ipn

  def index
  end

  def new
    @user = User.new
    @order = Order.new
  end

  def create
    
  end
end
