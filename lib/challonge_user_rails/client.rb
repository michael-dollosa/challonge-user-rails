require "faraday"
require "faraday_middleware"

module ChallongeUserRails
  class Client
    BASE_URL = "https://api.challonge.com/v2/"

    attr_reader :api_key, :adapter

    def initialize(api_key:, adapter: Faraday.default_adapter )
      @api_key = api_key
      @adapter = adapter
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = BASE_URL
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
        conn.headers['Content-Type'] = 'application/vnd.api+json'
        conn.headers['Accept'] = 'application/json'
        conn.headers['Authorization-Type'] = 'v1'
        conn.headers['Authorization'] = @api_key
        conn.use Faraday::Response::RaiseError
      end
    end

    #endpoints

    #get all tournaments from user account
    def tournaments
      response = connection.get("tournaments.json")
      { code: response.status, status: 'success', data: response.body }
    rescue Faraday::ClientError => err
      { code: err.response[:status], status: err.response[:headers][:status], data: JSON.parse(err.response[:body])["errors"]["detail"] }
    end

    #get specific tournament via slug/url
    def tournament(slug)
      response = connection.get("tournaments/#{slug}.json")
      { code: response.status, status: 'success', data: response.body }
    rescue Faraday::ClientError => err
      { code: err.response[:status], status: err.response[:headers][:status], data: JSON.parse(err.response[:body])["errors"]["detail"] }
    end

    #get all matches of specific tournament
    def matches(slug)
      response = connection.get("tournaments/#{slug}/matches.json")
      { code: response.status, status: 'success', data: response.body }
    rescue Faraday::ClientError => err
      { code: err.response[:status], status: err.response[:headers][:status], data: JSON.parse(err.response[:body])["errors"]["detail"] }
    end

    #get specific match
    def match(slug, id)
      response = connection.get("tournaments/#{slug}/matches/#{id}.json")
      { code: response.status, status: 'success', data: response.body }
    rescue Faraday::ClientError => err
      { code: err.response[:status], status: err.response[:headers][:status], data: JSON.parse(err.response[:body])["errors"]["detail"] }
    end

    #create tournament
    def create_tournament(data)
      response = connection.post("tournaments.json", data)
      { code: response.status, status: 'success', data: response.body }
    rescue Faraday::ClientError => err
      { code: err.response[:status], status: err.response[:headers][:status], data: JSON.parse(err.response[:body])["errors"]["detail"] }
    end

    #delete tournament
    def delete_tournament(slug)
      response = connection.delete("tournaments/#{slug}.json")
      { code: response.status, status: 'success', data: response.body }
    rescue Faraday::ClientError => err
      { code: err.response[:status], status: err.response[:headers][:status], data: JSON.parse(err.response[:body])["errors"]["detail"] }
    end

  end
end
