class PaymentsController < ApplicationController
  # @TODO Add Devise
  # before_filter :authenticate_user!
  before_action :set_order

  # GET /orders/:order_id/payment
  def show
    @payment = @order.payment
  end

  # GET /orders/:order_id/payment/new
  def new
    @payment = @order.payment.new
  end

  # POST /orders/:order_id/payment
  def create
    @payment = @order.payment.new(permitted_params)

    if @payment.save
      redirect_to @payment, notice: 'Payment was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /orders/:order_id/payment/1
  def update
    @payment = @order.payments.find(params.require(:id))

    if @payment.update(permitted_params)
      redirect_to @payment, notice: 'Payment was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /orders/:order_id/payment/:id
  def destroy
    @payment = @order.payments.find(params.require(:id))
    @payment.destroy

    redirect_to order_payments_path
  end

  private

  def set_order
    @order = current_user.orders.find(params.require(:order_id))
  end

  def permitted_params
    params.require(:payment)
  end
end
