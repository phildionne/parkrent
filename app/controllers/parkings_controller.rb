class ParkingsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]

  authorize_actions_for Parking, except: [:show, :edit, :update, :destroy]

  # GET /parkings
  def index
    if params[:search]
      parkings = Parking.near(search_params[:location], search_params[:distance])
    else
      parkings = Parking.all
    end

    @parkings = parkings.published.includes(:rents).paginate(page: params[:page], per_page: 10)

    respond_to do |format|
      format.html # index.html.erb
      format.rss  { render layout: false }
    end
  end

  # GET /parkings/1
  def show
    @parking = Parking.includes(:rents).find(params.require(:id))
    authorize_action_for(@parking)
  end

  # GET /parkings/new
  def new
    @parking = Parking.new
  end

  # GET /parkings/1/edit
  def edit
    @parking = Parking.find(params.require(:id))
    authorize_action_for(@parking)
  end

  # POST /parkings
  def create
    @parking = Parking.new(parking_params)
    @parking.user = current_user

    if @parking.save
      redirect_to @parking, notice: 'Parking was successfully created.'
    else
      render action: :new
    end
  end

  # PATCH/PUT /parkings/1
  def update
    @parking = Parking.find(params.require(:id))
    @parking.user = current_user

    authorize_action_for(@parking)

    if @parking.update(parking_params)
      redirect_to @parking, notice: 'Parking was successfully updated.'
    else
      render action: :edit
    end
  end

  # DELETE /parkings/1
  def destroy
    @parking = Parking.find(params.require(:id))

    authorize_action_for(@parking)

    @parking.destroy
    redirect_to root_path
  end

  private

  def parking_params
    params.require(:parking).permit(:location, :itinerary, :published)
  end

  def search_params
    params.require(:search).permit(:location, :distance, :start_date, :end_date)
  end
end
