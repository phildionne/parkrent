class OnboardingsController < ApplicationController
  prepend_before_action :require_no_authentication

  # GET /onboarding/new
  def new
    @onboarding = Onboarding.new
  end

  # POST /onboarding
  def create
    @onboarding = Onboarding.new(permitted_params)

    if @onboarding.register
      sign_in @onboarding.user

      redirect_to({ controller: 'parkings', action: :show, id: @onboarding.parking }, notice: 'Welcome aboard!')
    else
      render action: :new
    end
  end


  private

  def permitted_params
    params.require(:onboarding).permit(:first_name, :last_name, :phone_number,
      :email, :password, :password_confirmation, :location, :beginning, :termination, :price)
  end
end
