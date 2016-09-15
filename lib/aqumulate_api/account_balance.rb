module AqumulateAPI
  class AccountBalance

    ATTR_MAP = {
        type: 'AcctBalType',
        amount: 'AcctBalAmt',
        currency: 'CurCode'
    }

    attr_accessor :type, :amount, :currency

    def initialize(attributes = {})
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def self.from_source(source)
      account_balance = new

      ATTR_MAP.invert.each do |k, v|
        account_balance.send("#{v.to_s}=", source[k])
      end

      account_balance
    end

  end
end