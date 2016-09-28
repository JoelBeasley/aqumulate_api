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
        country: 'Country',
        ce_user_id: 'CEUserID'
    }

    attr_accessor :user_id, :password, :first_name, :last_name, :email, :phone, :ssn, :address_1, :address_2, :city,
                  :state, :zip, :country, :ce_user_id

    def self.find(user_id)
      response = AggAdvisor.get_advisor_by_id({ 'UserId' => user_id })
      raise RequestError.new(response['ErrorMessage'], response) if response.has_key?('ErrorMessage')

      advisor = from_source(response)
      advisor.user_id = user_id

      return advisor
    end

    def self.all
      response = AggAdvisor.get_advisors
      return [] unless response.has_key?('AdvisorList')
      response['AdvisorList'].map { |source|  from_source(source) }
    end

    def session_id(password = self.password)
      @session_id ||= AggAdvisor.advisor_sign_on('UserId' => user_id, 'Password' => password)['SessionId']
    end

    def save
      if ce_user_id.nil?
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

    private

    def create
      request = params
      request.delete('CEUserID')
      response = AggAdvisor.add_advisor(request)
      raise RequestError.new(response['ErrorMessage'], response) if response.has_key?('ErrorMessage')

      self.ce_user_id = response['CEUserID']

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