class RentPresenter < Bourgeois::Presenter

  def title
    "#{price.format} - #{schedule.to_s}"
  end
end
