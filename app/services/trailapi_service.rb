class TrailapiService
  attr_reader :connection

  def initialize
    @connection = Faraday.new(:url => 'https://trailapi-trailapi.p.mashape.com/') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      faraday.headers['X-Mashape-Key'] = ENV["TRAIL_API_KEY"]
      faraday.headers['Accept'] = "text/plain"
    end
  end

  def some_info
    parse_json(connection.get("?limit=20&q[activities_activity_type_name_eq]=snow+sports&q[state_cont]=Colorado"))
  end

  def search_results(params)
    if params[:city].empty? && params[:resort_name].empty?
      results = parse_json(connection.get("?limit=75&q[activities_activity_type_name_eq]=snow+sports&q[state_cont]=#{params[:state]}"))
    elsif params[:city].empty?
      results = parse_json(connection.get("?limit=50&q[activities_activity_name_cont]=#{params[:resort_name]}&q[activities_activity_type_name_eq]=snow+sports&q[state_cont]=#{params[:state]}"))
    elsif params[:resort_name].empty?
      results = parse_json(connection.get("?limit=50&q[activities_activity_type_name_eq]=snow+sports&q[city_cont]=#{params[:city]}&q[state_cont]=#{params[:state]}"))
    else
      results = parse_json(connection.get("?limit=20&q[activities_activity_name_cont]=#{params[:resort_name]}&q[activities_activity_type_name_eq]=snow+sports&q[city_cont]=#{params[:city]}&q[state_cont]=#{params[:state]}"))
    end
    clean_up_search(results, params)
  end

  def clean_up_search(results, params)
    new_hash = results[:places].map do |data|
      {
        name:          data[:name],
        official_name: data[:activities].first[:name],
        state:         data[:state],
        uid:           data[:unique_id],
        latitude:      data[:lat],
        longitude:     data[:lon],
        description:   data[:activities].first[:description],
        type:          data[:activities].first[:attribs]
      }
    end
    new_hash.delete_if { |result| !result[:name].downcase.include?(params[:resort_name].downcase)}
  end


  private
  def parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

end
