module AqumulateAPI
  class AccountBalance < Entity

    ATTR_MAP = {
        type: 'AcctBalType',
        amount: 'AcctBalAmt',
        currency: 'CurCode'
    }

    attr_accessor :type, :amount, :currency

  end
end