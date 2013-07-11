class OrdersController < ApplicationController

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
    @order = Order.find(params.require(:id))
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params.require(:id))
  end

  # POST /orders
  def create
    @order = Order.new(permitted_params)

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    @order = Order.find(params.require(:id))

    if @order.update(permitted_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order = Order.find(params.require(:id))

    @order.destroy
    redirect_to orders_path
  end

  private

  def permitted_params
    params.require(:order).permit(:rent_id)
  end
end
