class Admin::OrdersController < Admin::BaseController
  def show
    @orders_count = Order.daily_count
    respond_to do |format|
      format.json { render json: @orders_count }
    end
  end
end
