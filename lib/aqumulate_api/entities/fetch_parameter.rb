module AqumulateAPI
  class FetchParameter < Entity
    ATTR_MAP = {
        id: 'ParamId',
        caption: 'ParamCaption',
        size: 'ParamSize'
    }

    attr_accessor :id, :caption, :size
  end
end