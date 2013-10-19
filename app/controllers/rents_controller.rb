class RentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_parking

  authorize_actions_for Rent, except: [:new, :edit, :create, :update, :destroy]

  # GET parkings/:parking_id/rents/new
  def new
    @rent = Rent.new
    @rent.parking = @parking
    authorize_action_for(@rent)
  end

  # GET parkings/:parking_id/rents/1/edit
  def edit
    @rent = Rent.find(params.require(:id))
    authorize_action_for(@rent)
  end

  # POST parkings/:parking_id/rents
  def create
    @rent = Rent.new(permitted_params)
    @rent.parking = @parking

    authorize_action_for(@rent)

    if @rent.save
      redirect_to parking_path(@parking), notice: 'Rent was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT parkings/:parking_id/rents/1
  def update
    @rent = Rent.find(params.require(:id))

    authorize_action_for(@rent)

    if @rent.update_attributes(permitted_params)
      redirect_to parking_path(@parking), notice: 'Rent was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE parkings/:parking_id/rents/1
  def destroy
    @rent = Rent.find(params.require(:id))

    authorize_action_for(@rent)

    @rent.destroy
    redirect_to parking_path(@parking)
  end


  private

  def set_parking
    @parking = Parking.find(params.require(:parking_id))
    authorize_action_for(@parking)
  end

  def permitted_params
    params.require(:rent).permit(:price, :beginning, :termination)
  end
end
