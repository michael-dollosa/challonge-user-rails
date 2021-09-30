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
      end
    end

    #endpoints

    #get all tournaments from user account
    def tournaments
      res = connection.get("tournaments.json").body
    end

    #get specific tournament via slug/url
    def tournament(slug)
      connection.get("tournaments/#{slug}.json").body
    end

    #get all matches of specific tournament
    def matches(slug)
      connection.get("tournaments/#{slug}/matches.json").body
    end

    #get specific match
    def match(slug, id)
      connection.get("tournaments/#{slug}/matches/#{id}.json").body
    end

    #create tournament
    def create_tournament(data)
      connection.post("tournaments.json", data).body
    end

    #delete tournament
    def delete_tournament(slug)
      connection.delete("tournaments/#{slug}.json").body
    end

    #change once deployed
    def inspect
      "#<ChallongUserAPI::Client>"
    end
  end
end