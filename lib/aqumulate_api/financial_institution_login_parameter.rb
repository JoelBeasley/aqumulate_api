module AqumulateAPI
  class FinancialInstitutionLoginParameter

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

    def initialize(attributes = {})
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def self.from_source(source)
      login_parameter = new({})

      ATTR_MAP.invert.each do |k, v|
        login_parameter.send("#{v.to_s}=", source[k])
      end

      login_parameter
    end

  end
end