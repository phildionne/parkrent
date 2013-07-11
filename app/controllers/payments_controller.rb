class PaymentsController < ApplicationController
  before_action :set_order

  # GET /orders/:order_id/payments
  def index
    @payments = @order.payments
  end

  # GET /orders/:order_id/payments/:id
  def show
    @payment = @order.payments.find(params.require(:id))
  end

  # GET /orders/:order_id/payments/new
  def new
    @payment = @order.payments.new
  end

  # POST /orders/:order_id/payments
  def create
    @payment = @order.payments.new(permitted_params)

    if @payment.save
      redirect_to @payment, notice: 'Payment was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /orders/:order_id/payments/1
  def update
    @payment = @order.payments.new(permitted_params)

    if @payment.update(permitted_params)
      redirect_to @payment, notice: 'Payment was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /orders/:order_id/payments/:id
  def destroy
    @payment = @order.payments.find(params.require(:id))
    @payment.destroy

    redirect_to order_payments_path
  end

  private

  def set_order
    @order = Order.find(params.require(:order_id))
  end

  def permitted_params
    params.require(:payment)
  end
end
