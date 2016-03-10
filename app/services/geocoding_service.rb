class GeocodingService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => 'https://maps.googleapis.com/maps/api/geocode/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def zip(lat, long)
    raw = parse_json(connection.get("json?latlng=#{lat},#{long}&key=AIzaSyAqFCE_WcES8oPiBY4bbNSS3r6p-9BtIgM"))
    only_zip(raw)
  end

  def only_zip(info)
    info[:results].first[:address_components][-1][:long_name]
  end

  private

  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
