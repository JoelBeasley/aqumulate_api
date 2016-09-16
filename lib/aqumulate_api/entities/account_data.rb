module AqumulateAPI
  class AccountData < Entity

    ATTR_MAP = {
        id: 'AcctTypeId',
        group: 'AcctGroup',
        name: 'AcctName',
        type: 'AcctType',
        ext_type: 'ExtAcctName'
    }

    attr_accessor :id, :group, :name, :type, :ext_type

  end
end