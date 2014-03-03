class OrdersController < ApplicationController
  before_filter :authenticate_user!

  authorize_actions_for Order, except: [:show, :edit, :update, :destroy]

  # GET /orders
  def index
  end

  # GET /orders/1
  def show
    @order = Order.find(params.require(:id))
    authorize_action_for(@order)
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @order   = Order.find(params.require(:id))
    @rent    = @order.rent
    @vehicle = Vehicle.new

    authorize_action_for(@order)
  end

  # PATCH/PUT /orders/1
  def update
    @order = Order.find(params.require(:id))

    authorize_action_for(@order)

    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: :edit
    end
  end


  private

  def order_params
    params.require(:order).permit(:rent_id, :vehicle_id)
  end

  def vehicle_params
    params.require(:vehicle).permit(:license_plate, :year, :model)
  end
end
