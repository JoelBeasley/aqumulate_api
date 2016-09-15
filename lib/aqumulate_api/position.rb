module AqumulateAPI
  class Position

    ATTR_MAP = {
        id: 'PosID',
        date: 'Date',
        ticker: 'Ticker',
        description: 'Description',
        asset_id: 'AssetID',
        asset_type: 'AssetIDType',
        price: 'Price',
        quantity: 'Quantity',
        market_value: 'MarketValue',
        cost_basis: 'CostBasis'
    }

    attr_accessor :id, :date, :ticket, :description, :asset_id, :asset_type, :price, :quantity, :market_value,
                  :cost_basis

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