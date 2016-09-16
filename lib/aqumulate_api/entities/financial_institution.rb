module AqumulateAPI
  class FinancialInstitution < Entity

    SOURCE_ASSOCIATIONS = [
        { key: 'FILoginParameters', class: LoginParameter, attr: :login_parameters },
        { key: 'FiFetchParamList', class: FetchParameter, attr: :fetch_parameters },
        { key: 'FiAccountDataList', class: AccountData, attr: :account_data },
    ]

    ATTR_MAP = {
        id: 'FIId',
        name: 'FIName',
        url: 'Url',
    }

    attr_accessor :id, :name, :url, :login_parameters, :fetch_parameters, :account_data

    def login_parameters
      @login_parameters ||= []
    end

    def fetch_parameters
      @fetch_parameters ||= []
    end

    def account_data
      @account_data ||= []
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