module AqumulateAPI
  class FinancialInstitution < Entity

    SOURCE_ASSOCIATIONS = [
        { key: 'FILoginParameters', class: LoginParameter, attr: :login_parameters },
        { key: 'FiFetchParamList', class: FetchParameter, attr: :fetch_parameters },
    ]

    ATTR_MAP = {
        id: 'FIId',
        name: 'FIName',
        url: 'Url',
    }

    attr_accessor :id, :name, :url, :login_parameters, :fetch_parameters

    def login_parameters
      @login_parameters ||= []
    end

    def fetch_parameters
      @fetch_parameters ||= []
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

  end
end