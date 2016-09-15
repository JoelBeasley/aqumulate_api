module AqumulateAPI
  class Account

    ATTR_MAP = {
        id: 'AcctId',
        login_account_id: 'FILoginAcctId',
        added_by: 'AccountAddedBy',
        financial_institution_id: 'FIId',
        account_type: 'AccountType',
        account_type_extended: 'ExtendedAccountType',
        nick_name: 'NickNameAtFI',
        update_error_code: 'UpdateErrorCode',
        retirement_status: 'RetirementStatus',
        instrument: 'Instrument',
        ownership: 'AccountOwnership',
        adv_access: 'AdvAccess',
        tracking_code: 'TrackingCode',
        account_balances: 'LastSuccessfulUpdate',
        last_update_status_code: 'LastUpdateStatusCode',
        last_update_status_msg: 'LastUpdateStatusMsg',
        last_update_status_msg_fi: 'LastUpdateStatusMessageAtFI',
        last_update_attempt: 'LastUpdateAttempt',
        last_update: 'LastSuccessfulUpdate'
    }

    attr_accessor :id, :login_account_id, :added_by, :financial_institution_id, :account_type, :account_type_extended,
                  :nick_name, :update_error_code, :retirement_status, :instrument, :ownership, :adv_access,
                  :tracking_code, :last_update_status_code, :last_update_status_msg, :last_update_status_msg_fi,
                  :last_update_attempt, :last_update

    def initialize(attributes = {})
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def self.find(advisor, fi_id = nil)
      body = { 'SessionId' => advisor.session_id }
      body['FIId'] = fi_id unless fi_id.nil?

      response = AggAccount.advisor_agg_get_account_for_fi(body)
      return [] unless response.has_key?('Accounts')

      response['Accounts'].map { |source| from_source(source) }
    end

    def self.from_source(source)
      account = new

      ATTR_MAP.invert.each do |k, v|
        account.send("#{v.to_s}=", source[k])
      end

      source['AccountBalances'].each do |acct_bal_source|
        account.account_balances << AccountBalance.from_source(acct_bal_source)
      end

      source['Positions'].each do |pos_source|
        account.positions << Position.from_source(pos_source)
      end

      account
    end

    def account_balances
      @account_balances ||= []
    end

    def positions
      @positions ||= []
    end

    def financial_institution
      @financial_institution ||= FinancialInstitution.find(financial_institution_id)
    end

  end
end