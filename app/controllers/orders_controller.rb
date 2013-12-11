class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :ipn

  def index
  end

  def new
    @user = User.new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.build_user(email: params[:email])
    @order.price = Settings.price

    if @order.save
      redirect_to :root, notice: "Thanks champ"
    else
      render :new
    end
  end

  protected

  def order_params
    attrs = params.require(:order).permit(:zip, :city, :state, :country, :address_one, :address_two, :phone, :name)
    attrs[:stripe_token] = params.require(:stripeToken)
    attrs
  end

end
