class VehiclesController < ApplicationController
  before_filter :authenticate_user!

  authorize_actions_for Vehicle, except: [:edit, :update, :destroy]

  # GET /vehicles/new
  def new
    @vehicle = Vehicle.new
  end

  # GET /vehicles/1/edit
  def edit
    @vehicle = Vehicle.find(params.require(:id))
    authorize_action_for(@vehicle)
  end

  # POST /vehicles
  def create
    @vehicle = Vehicle.new(permitted_params)
    @vehicle.user = current_user

    if @vehicle.save
      redirect_to root_path, notice: 'Vehicle was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /vehicles/1
  def update
    @vehicle = Vehicle.find(params.require(:id))

    authorize_action_for(@vehicle)

    if @vehicle.update_attributes(permitted_params)
      redirect_to root_path, notice: 'Vehicle was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /vehicles/1
  def destroy
    @vehicle = Vehicle.find(params.require(:id))

    authorize_action_for(@vehicle)

    @vehicle.destroy
    redirect_to root_path
  end

  private

  def permitted_params
    params.require(:vehicle).permit(:license_plate, :year, :model)
  end
end
