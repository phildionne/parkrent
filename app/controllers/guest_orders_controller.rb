class GuestOrdersController < ApplicationController
  prepend_before_action :require_no_authentication

  # GET /guest_order/new
  def new
    @guest_order      = GuestOrder.new
    @guest_order.rent = Rent.find(params.require(:rent_id))
  end

  # POST /guest_order
  def create
    @guest_order = GuestOrder.new(permitted_params)

    if @guest_order.save
      if @guest_order.user.active_for_authentication?
        sign_in @guest_order.user

        redirect_to @guest_order.order, notice: I18n.t('guest_orders.order_created_and_signed_up')
      else
        # @FIXME Same problem than OnboardingsController#create
        redirect_to root_path, notice: I18n.t('guest_orders.order_created_and_signed_up_but_unconfirmed')
      end
    else
      # @TODO Same problem than OnboardingsController#create
      render action: :new
    end
  end


  private

  def permitted_params
    params.require(:guest_order).permit(:first_name, :last_name, :phone_number,
      :email, :password, :password_confirmation, :license_plate, :year, :model, :rent_id)
  end
end
