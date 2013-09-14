module ParkingsHelper

  # Returns a rss formatted URL of parkings search results
  #
  # @param options [Hash]
  def parkings_search_results_rss_url(options = {})
    options.merge!(search: params[:search]) if params[:search]
    parkings_url(options.merge({ format: :rss }))
  end
end
