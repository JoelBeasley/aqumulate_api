module AqumulateAPI

  class << self
    attr_accessor :config
  end

  def self.config
    @configuration ||= Configuration.new
  end

  def self.configure
    yield config
  end

  class Configuration
    attr_accessor :grant_type, :password, :url, :username, :debug, :timeout

    def initialize
      @grant_type = 'password'
      @url = 'https://advagg.aqumulate.com'
      @debug = false
      @timeout = 300
    end
  end

end
