module AqumulateAPI
  class AggAccount

    RESOURCE = 'AggAccount'

    def self.add_advisor(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AddAdvisor", body)
    end
    
    def self.advisor_sign_on(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AdvisorSignOn", body)
    end
    
    def self.get_advisor_by_id(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/GetAdvisorById", body)
    end
    
    def self.update_advisor(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/UpdateAdvisor", body)
    end
    
    def self.delete_advisor(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/DeleteAdvisor", body)
    end

    def self.advisor_harvest_accounts(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AdvisorHarvestAccounts", body)
    end

    def self.advisor_harvest_account_status_check(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AdvisorHarvestAccountStatusCheck", body)
    end

    def self.advisor_get_aggregate_account(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AdvisorGetAggregateAccount", body)
    end

    def self.advisor_agg_get_account_for_fi(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AdvisorAggGetAccountForFI", body)
    end

    def self.link_account_to_Client(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/LinkAccountToClient", body)
    end

    def self.advisor_get_transactions_by_date(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/ADvisorGetTransactionsByDate", body)
    end

    def self.advisor_get_financial_institution(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AdvisorGetFinancialInstitution", body)
    end

    def self.advisor_search_financial_institution(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AdvisorSearchFinancialInstitution", body)
    end

    def self.advisor_add_account(body, session = AqumulateAPI.session)
      session.api_request("#{RESOURCE}/AdvisorAddAccount", body)
    end

  end
end