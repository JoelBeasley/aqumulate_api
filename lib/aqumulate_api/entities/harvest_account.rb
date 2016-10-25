module AqumulateAPI
  class HarvestAccount < Entity

    ATTR_MAP = {
        id: 'HarvestID',
        status: 'HarvestStatus',
    }

    attr_accessor :id, :status

  end
end