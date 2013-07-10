class RentsController < ApplicationController

  # GET /rents
  def index
    @rents = Rent.all
  end

  # GET /rents/1
  def show
    @rent = Rent.find(params.require(:id))
  end

  # GET /rents/new
  def new
    @rent = Rent.new
  end

  # GET /rents/1/edit
  def edit
    @rent = Rent.find(params.require(:id))
  end

  # POST /rents
  def create
    @rent = Rent.new(permitted_params)

    if @rent.save
      redirect_to @rent, notice: 'Rent was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /rents/1
  def update
    @rent = Rent.find(params.require(:id))

    if @rent.update_attributes(permitted_params)
      redirect_to @rent, notice: 'Rent was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /rents/1
  def destroy
    @rent = Rent.find(params.require(:id))
    @rent.destroy

    redirect_to rents_url
  end

  private

  def permitted_params
    params.require(:rent).permit(:price, :beginning, :termination)
  end
end
