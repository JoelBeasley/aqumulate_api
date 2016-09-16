module AqumulateAPI
  class Position < Entity

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
  end
end