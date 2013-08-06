class FrontpageController < ApplicationController

  # GET /
  def show

    if current_user
      render 'homepage'
    else
      @onboarding = Onboarding.new

      render 'frontpage'
    end
  end
end
