application_name = Rails.application.class.parent_name
search_query = params[:search].try(:map) { |k,v| "#{k}: #{v}" }
feed_description = params[:search] ? "#{application_name} parkings search results for: #{search_query.to_sentence}" : "#{application_name} parkings"

xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title application_name
    xml.description feed_description
    xml.link parkings_search_results_rss_url

    @parkings.each do |parking|
      xml.item do
        xml.title parking.location
        xml.description parking.rents.map(&:title).to_sentence
        xml.pubDate parking.created_at.rfc822
        xml.link parking_url(parking)
        xml.guid parking_url(parking)
      end
    end
  end
end
