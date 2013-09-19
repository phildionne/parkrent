class GuestOrdersController < ApplicationController
  prepend_before_action :require_no_authentication

  # GET /guest_order/new
  def new
    @guest_order = GuestOrder.new
  end

  # POST /guest_order
  def create
    @guest_order = GuestOrder.new(permitted_params)

    if @guest_order.process
      sign_in @guest_order.user

      redirect_to @guest_order.order, notice: 'Order was successfully created.'
    else
      render action: :new
    end
  end


  private

  def permitted_params
    params.require(:guest_order).permit(:first_name, :last_name, :phone_number,
      :email, :password, :password_confirmation, :license_plate, :year, :model, :rent_id)
  end
end
