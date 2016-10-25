module AqumulateAPI
  class Advisor < Entity

    ATTR_MAP = {
        user_id: 'UserId',
        password: 'Password',
        first_name: 'FirstName',
        last_name: 'LastName',
        email: 'Email',
        phone: 'Phone',
        ssn: 'SSN',
        address_1: 'Address1',
        address_2: 'Address2',
        city: 'City',
        state: 'StateProvidence',
        zip: 'ZipCode',
        country: 'Country'
    }

    attr_accessor :user_id, :password, :first_name, :last_name, :email, :phone, :ssn, :address_1, :address_2, :city,
                  :state, :zip, :country, :persisted

    def self.find(user_id)
      response = AggAdvisor.get_advisor_by_id({ 'UserId' => user_id })
      AqumulateAPI.session.check_raise_request_error(response)

      advisor = from_source(response)
      advisor.user_id = user_id

      return advisor
    end

    def self.all
      response = AggAdvisor.get_advisors
      return [] unless response.has_key?('AdvisorList')
      response['AdvisorList'].map { |source| from_source(source) }
    end

    def session_id(password = self.password)
      @session_id ||= AggAdvisor.advisor_sign_on('UserId' => user_id, 'Password' => password)['SessionId']
    end

    def save
      if !persisted
        create
      else
        update
      end
    end

    def destroy
      AggAdvisor.delete_advisor({ 'UserID' => user_id })
      return true
    end

    def accounts(fi_id = nil)
      Account.fetch(self, fi_id)
    end

    def add_account(fi_id, login_parameters, fetch_parameters)
      AggAccount.advisor_add_account(
          {
              'SessionId' => session_id,
              'FIId' => fi_id,
              'FIType' => 'Advisor',
              'FIFetchParamList' => fetch_parameters,
              'ParameterList' => login_parameters
          }
      )
    end

    def harvest_account(fi_id)
      response = AggAccount.advisor_harvest_accounts(
          {
              'SessionId' => session_id,
              'FIId' => fi_id,
          }
      )

      HarvestAccount.from_source(response)
    end

    private

    def create
      response = AggAdvisor.add_advisor(params)
      AqumulateAPI.session.check_raise_request_error(response)

      self.persisted = true

      return self
    end

    def update
      AggAdvisor.update_advisor(params)

      return self
    end

    def params
      ATTR_MAP.map { |k, v| [v, send(k)] }.to_h
    end

  end
end