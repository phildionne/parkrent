class FrontpageController < ApplicationController

  # GET /
  def show
    if current_user.authenticated?
      @user = current_user

      @parkings = current_user.parkings
      @orders = current_user.orders

      render 'homepage'
    else
      @onboarding = Onboarding.new

      render 'frontpage'
    end
  end
end
