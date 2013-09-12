class VehiclesController < ApplicationController
  before_filter :authenticate_user!

  # GET /vehicles/new
  def new
    @vehicle = current_user.vehicles.new
  end

  # GET /vehicles/1/edit
  def edit
    @vehicle = current_user.vehicles.find(params.require(:id))
  end

  # POST /vehicles
  def create
    @vehicle = current_user.vehicles.new(permitted_params)

    if @vehicle.save
      redirect_to root_path, notice: 'Vehicle was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /vehicles/1
  def update
    @vehicle = current_user.vehicles.find(params.require(:id))

    if @vehicle.update_attributes(permitted_params)
      redirect_to root_path, notice: 'Vehicle was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle = current_user.vehicles.find(params.require(:id))
    @vehicle.destroy

    redirect_to root_path
  end

  private

  def permitted_params
    params.require(:vehicle).permit(:license_plate)
  end
end
