class LineItemsController < ApplicationController
  before_action :set_order

  # GET /orders/:order_id/line_items
  def index
    @line_items = @order.line_items
  end

  # GET /orders/:order_id/line_items/:id
  def show
    @line_item = @order.line_items.find(params.require(:id))
  end

  # GET /orders/:order_id/line_items/new
  def new
    @line_item = @order.line_items.new
  end

  # POST /orders/:order_id/line_items
  def create
    @line_item = @order.line_items.new(permitted_params)

    if @line_item.save
      redirect_to @line_item, notice: 'Line item was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /orders/:order_id/line_items/1
  def update
    @line_item = @order.line_items.new(permitted_params)

    if @line_item.update(permitted_params)
      redirect_to @line_item, notice: 'Line item was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /orders/:order_id/line_items/:id
  def destroy
    @line_item = LineItem.find(params.require(:id))
    @line_item.destroy

    redirect_to order_line_items_path
  end

  private

  def set_order
    @order = Order.find(params.require(:order_id))
  end

  def permitted_params
    params.require(:line_item)
  end
end
