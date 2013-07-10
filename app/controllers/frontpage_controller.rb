class FrontpageController < ApplicationController

  # GET /
  def show

    if true

      render 'homepage'
    else
      render 'frontpage'
    end
  end
end
