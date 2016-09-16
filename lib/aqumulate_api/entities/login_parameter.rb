module AqumulateAPI
  class LoginParameter < Entity

    ATTR_MAP = {
        id: 'ParameterId',
        number: 'ParameterNumber',
        type: 'ParameterType',
        max_length: 'ParameterMaxLength',
        size: 'ParameterSize',
        caption: 'ParameterCaption',
        variable_name: 'ParameterVariableName',
        default_value: 'ParameterDefaultValue',
        editable: 'ParameterEditable',
        sensitivity_code: 'ParameterSensitivityCode'
    }

    attr_accessor :id, :number, :type, :max_length, :size, :caption, :variable_name, :default_value, :editable,
                  :sensitivity_code, :value
  end
end