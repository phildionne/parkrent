class OnboardingsController < ApplicationController
  prepend_before_action :require_no_authentication

  # GET /onboarding/new
  def new
    @onboarding = Onboarding.new
  end

  # POST /onboarding
  def create
    @onboarding = Onboarding.new(permitted_params)

    if @onboarding.save
      if @onboarding.user.active_for_authentication?
        sign_in @onboarding.user

        redirect_to({ controller: 'parkings', action: :show, id: @onboarding.parking }, notice: I18n.t('devise.registrations.signed_up'))
      else
        # @FIXME This notice could be false, depending on the state of the registration
        redirect_to root_path, notice: I18n.t('devise.registrations.signed_up_but_unconfirmed')
      end
    else
      # @TODO Need to manually cleanup passwords?
      render action: :new
    end
  end


  private

  def permitted_params
    params.require(:onboarding).permit(:first_name, :last_name, :phone_number,
      :email, :password, :password_confirmation, :location, :start_time, :end_time, :price)
  end
end
