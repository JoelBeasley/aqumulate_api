module AqumulateAPI
  class Session

    attr_reader :config, :auth

    def initialize
      if block_given?
        @config = AqumulateAPI::Configuration.new
        yield(@config)
      else
        @config = AqumulateAPI.config
      end

      login
    end

    def login
      response = HTTParty.post(
          "#{config.url}/token",
          headers: { 'Accept' => 'application/x-www-form-urlencoded' },
          body: {
              grant_type: config.grant_type,
              'userName' => config.username,
              password: config.password
          }
      )

      @auth = handle_response response
    end

    def handle_response(response)
      if response.parsed_response.is_a?(Hash) && response.parsed_response.has_key?('error')
        raise AuthenticationError.new(response.parsed_response['error_description'], response.request)

      elsif response.code != 200
        raise RequestError.new(response.response.msg, response.response)
      end

      response.parsed_response
    end

  end
end