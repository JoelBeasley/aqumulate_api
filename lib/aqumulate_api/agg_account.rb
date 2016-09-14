module AqumulateAPI
  class AggAccount
    RESOURCE = 'AggAccount'
  end

  AggAccount.singleton_class.class_eval do
    methods = {
        advisor_harvest_accounts: { method: 'AdvisorHarvestAccounts' },
        advisor_harvest_account_status_check: { method: 'AdvisorHarvestAccountStatusCheck' },
        advisor_get_aggregate_account: { method: 'AdvisorGetAggregateAccount' },
        advisor_agg_get_account_for_fi: { method: 'AdvisorAggGetAccountForFI' },
        link_account_to_client: { method: 'LinkAccountToClient' },
        advisor_get_transactions_by_date: { method: 'AdvisorGetTransactionsByDate' },
        advisor_search_financial_institution: { method: 'AdvisorSearchFinancialInstitution' },
        advisor_get_financial_institution: { method: 'AdvisorGetFinancialInstitution' },
        advisor_add_account: { method: 'AdvisorAddAccount' }
    }

    methods.each do |method, definition|
      define_method(method) do |body = {}, session = AqumulateAPI.session|
        session.api_request("#{self::RESOURCE}/#{definition[:method]}", body)
      end
    end
  end
end