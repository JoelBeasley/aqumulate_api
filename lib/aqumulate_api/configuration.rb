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
    attr_accessor :grant_type, :password, :url, :username

    def initialize
      @grant_type = 'password'
      @url = 'https://advagg.aqumulate.com'
    end
  end

end
