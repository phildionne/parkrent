class RentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_parking

  # GET parkings/:parking_id/rents/new
  def new
    @rent = @parking.rents.new
  end

  # GET parkings/:parking_id/rents/1/edit
  def edit
    @rent = @parking.rents.find(params.require(:id))
  end

  # POST parkings/:parking_id/rents
  def create
    @rent = @parking.rents.new(permitted_params)

    if @rent.save
      redirect_to parking_path(@parking), notice: 'Rent was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT parkings/:parking_id/rents/1
  def update
    @rent = @parking.rents.find(params.require(:id))

    if @rent.update_attributes(permitted_params)
      redirect_to parking_path(@parking), notice: 'Rent was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE parkings/:parking_id/rents/1
  def destroy
    @rent = @parking.rents.find(params.require(:id))
    @rent.destroy

    redirect_to parking_path(@parking)
  end

  private

  def set_parking
    @parking = current_user.parkings.find(params.require(:parking_id))
  end

  def permitted_params
    params.require(:rent).permit(:price, :beginning, :termination)
  end
end
