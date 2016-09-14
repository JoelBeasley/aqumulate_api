module AqumulateAPI
  class FinancialInstitution

    ATTR_MAP = {
        id: 'FIId',
        name: 'FIName',
        url: 'Url',
    }

    attr_accessor :id, :name, :url, :login_parameters

    def initialize(attributes = {})
      @login_parameters = []
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def self.find(id)
      response = AggAccount.advisor_get_financial_institution({ 'FIId' => id })
      from_source(response['FinancialInstitution'])
    end

    def self.search(keyword)
      response = AggAccount.advisor_search_financial_institution({ 'Keyword' => keyword })
      return [] unless response.has_key?('FinancialInstitutions')

      response['FinancialInstitutions'].map { |source| from_source(source) }
    end

    def self.from_source(source)
      financial_institution = new({})

      ATTR_MAP.invert.each do |k, v|
        financial_institution.send("#{v.to_s}=", source[k])
      end

      source['FILoginParameters'].each do |param_source|
        financial_institution.login_parameters << FinancialInstitutionLoginParameter.from_source(param_source)
      end

      financial_institution
    end
  end
end