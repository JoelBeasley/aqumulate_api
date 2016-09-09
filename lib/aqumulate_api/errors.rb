module AqumulateAPI
  class AuthenticationError < StandardError
    attr_reader :request

    def initialize(msg, request)
      @request = request
      super msg
    end
  end

  class RequestError < StandardError
    attr_reader :request

    def initialize(msg, request)
      @request = request
      super msg
    end
  end
end