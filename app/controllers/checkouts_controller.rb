class CheckoutsController < ApplicationController

  # GET /checkout/new
  def new
    @checkout = Checkout.new
  end

  # POST /checkout
  def create
    @checkout = Checkout.new(permitted_params)

    if @checkout.process
      sign_in @checkout.user

      redirect_to @checkout.order, notice: 'Order was successfully created.'
    else
      render action: :new
    end
  end


  private

  def permitted_params
    params.require(:checkout).permit(:first_name, :last_name, :phone_number,
      :email, :password, :password_confirmation, :license_plate, :year, :model, :rent_id)
  end
end
