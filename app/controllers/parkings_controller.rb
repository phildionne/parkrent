class ParkingsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  # GET /parkings
  def index
    if params[:search]
      # @parkings = Parking.near(permitted_search_params[:location], 20, order: :distance)
      @parkings = Parking.near(permitted_search_params[:location], permitted_search_params[:distance])
    else
      @parkings = Parking.all
    end
  end

  # GET /parkings/1
  def show
    @parking = Parking.includes(:rents).find(params.require(:id))
  end

  # GET /parkings/new
  def new
    @parking = Parking.new
  end

  # GET /parkings/1/edit
  def edit
    @parking = Parking.find(params.require(:id))
  end

  # POST /parkings
  def create
    @parking = Parking.new(permitted_params)

    if @parking.save
      redirect_to @parking, notice: 'Parking was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /parkings/1
  def update
    @parking = Parking.find(params.require(:id))

    if @parking.update_attributes(permitted_params)
      redirect_to @parking, notice: 'Parking was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /parkings/1
  def destroy
    @parking = Parking.find(params.require(:id))
    @parking.destroy

    redirect_to parkings_path
  end

  private

  def permitted_params
    params.require(:parking).permit(:location)
  end

  def permitted_search_params
    params.require(:search).permit(:location, :distance, :beginning, :termination)
  end
end
