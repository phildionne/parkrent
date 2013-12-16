class CheckoutsController < ApplicationController
  before_filter :authenticate_user!

  authorize_actions_for Order, except: [:show, :edit, :update, :destroy]

  # GET /checkout/new
  def new
    @checkout = Checkout.new
  end

  # POST /checkout
  def create
    @checkout = Checkout.new(checkout_params)
    @checkout.user = current_user

    if @checkout.save
      redirect_to @checkout.order, notice: I18n.t('checkouts.created')
    else
      render action: :new
    end
  end


  private

  def checkout_params
    params.require(:checkout).permit(:rent_id, :vehicle_id, :license_plate, :year, :model)
  end
end
