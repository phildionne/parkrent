class OrdersController < ApplicationController
  before_filter :authenticate_user!

  authorize_actions_for Order, except: [:show, :edit, :update, :destroy]

  # GET /orders/1
  def show
    @order = Order.find(params.require(:id))
    authorize_action_for(@order)
  end

  # GET /orders/new
  def new
    @order   = Order.new
    @order.user = current_user
    @rent    = Rent.find(params.require(:rent_id))
    @vehicle = Vehicle.new
  end

  # GET /orders/1/edit
  def edit
    @order   = Order.find(params.require(:id))
    @rent    = @order.rent
    @vehicle = Vehicle.new

    authorize_action_for(@order)
  end

  # POST /orders
  def create
    @order   = Order.new(permitted_params)
    @order.user = current_user
    @rent    = @order.rent
    @vehicle = Vehicle.new

    # Build and persist a newly created vehicle
    if params[:vehicle].present?
      @vehicle = Vehicle.new(permitted_vehicle_params)
      @vehicle.user = current_user

      authorize_action_for(@vehicle)

      if @vehicle.save
        @order.vehicle = @vehicle
      end
    end

    # Use application secret key to save customers on the app's account instead
    # than on each merchant account
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']

    begin
      charge = Stripe::Charge.create(
        amount:      @rent.price.cents,
        currency:    @rent.price.currency_as_string,
        card:        params[:stripeToken],
        description: current_user.email,
        #   application_fee
      )
    rescue Stripe::CardError => e
      ap 'The card has been declined'
    end

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    @order = Order.find(params.require(:id))

    authorize_action_for(@order)

    if @order.update(permitted_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order = Order.find(params.require(:id))

    authorize_action_for(@order)

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
