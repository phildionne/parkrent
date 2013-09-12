class OrdersController < ApplicationController
  before_filter :authenticate_user!

  # GET /orders
  def index
    @orders = Order.all
  end

  # GET /orders/1
  def show
    @order = current_user.orders.find(params.require(:id))
  end

  # GET /orders/new
  def new
    @order = current_user.orders.new
    @rent = Rent.find(params.require(:rent_id))
    @vehicle = Vehicle.new
  end

  # GET /orders/1/edit
  def edit
    @order = current_user.orders.find(params.require(:id))
  end

  # POST /orders
  def create
    @order = current_user.orders.new(permitted_params)

    # Build and persist a newly created vehicle when none exist
    if @order.user.vehicles.none?
      @vehicle = @order.user.vehicles.new(permitted_vehicle_params)

      if @vehicle.save
        @order.vehicle = @vehicle
      end
    end

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    @order = current_user.orders.find(params.require(:id))

    if @order.update(permitted_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order = current_user.orders.find(params.require(:id))

    @order.destroy
    redirect_to orders_path
  end

  private

  def permitted_params
    params.require(:order).permit(:rent_id, :vehicle_id)
  end

  def permitted_vehicle_params
    params.require(:vehicle).permit(:license_plate, :year, :model)
  end
end
