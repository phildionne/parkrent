class FrontpageController < ApplicationController

  # GET /
  def show

    if current_user
      render 'homepage'
    else
      render 'frontpage'
    end
  end
end
