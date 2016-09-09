module AqumulateAPI
  class AggAccount
    RESOURCE = 'AggAccount'
  end

  AggAccount.singleton_class.class_eval do
    methods = {
        add_advisor: { resource: 'AddAdvisor' },
        advisor_sign_on: { resource: 'AdvisorSignOn' },
        get_advisor_by_id: { resource: 'GetAdvisorById' },
        update_advisor: { resource: 'UpdateAdvisor' },
        delete_advisor: { resource: 'DeleteAdvisor' },
        advisor_harvest_accounts: { resource: 'AdvisorHarvestAccounts' },
        advisor_harvest_account_status_check: { resource: 'AdvisorHarvestAccountStatusCheck' },
        advisor_get_aggregate_account: { resource: 'AdvisorGetAggregateAccount' },
        advisor_agg_get_account_for_fi: { resource: 'AdvisorAggGetAccountForFI' },
        link_account_to_client: { resource: 'LinkAccountToClient' },
        advisor_get_transactions_by_date: { resource: 'AdvisorGetTransactionsByDate' },
        advisor_search_financial_institution: { resource: 'AdvisorSearchFinancialInstitution' },
        advisor_get_financial_institution: { resource: 'AdvisorGetFinancialInstitution' },
        advisor_add_account: { resource: 'AdvisorAddAccount' }
    }

    methods.each do |method, definition|
      define_method(method) do |body, session = AqumulateAPI.session|
        session.api_request("#{self::RESOURCE}/#{definition[:resource]}", body)
      end
    end
  end
end