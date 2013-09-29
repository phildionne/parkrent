class FrontpageController < ApplicationController

  # GET /
  def show
    if current_user.authenticated?
      @parkings = current_user.parkings
      @orders = current_user.orders

      render 'homepage'
    else
      @onboarding = Onboarding.new

      render 'frontpage'
    end
  end
end
