class GuestOrdersController < ApplicationController
  prepend_before_action :require_no_authentication

  # GET /guest_order/new
  def new
    # @FIXME With an inexisting rent_id passed in the params, the view defaults to the first one
    # Kind of a strange default behavior
    @guest_order = GuestOrder.new(params.permit(:rent_id))
  end

  # POST /guest_order
  def create
    @guest_order = GuestOrder.new(guest_order_params)

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

  def guest_order_params
    params.require(:guest_order).permit(:first_name, :last_name, :phone_number,
      :email, :password, :password_confirmation, :license_plate, :year, :model, :rent_id)
  end
end
