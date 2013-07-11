class LineItemsController < ApplicationController
  before_action :set_order

  # GET /line_items
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  def show
    @line_item = LineItem.find(params[:id])
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  def create
    @line_item = LineItem.new(permitted_params)

    if @line_item.save
      redirect_to @line_item, notice: 'Line item was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /line_items/1
  def update
    @line_item = LineItem.find(params[:id])

    if @line_item.update(permitted_params)
      redirect_to @line_item, notice: 'Line item was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /line_items/1
  def destroy
    @line_item = LineItem.find(params[:id])
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
