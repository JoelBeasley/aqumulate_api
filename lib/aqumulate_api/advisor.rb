module AqumulateAPI
  class Advisor

    ATTR_MAP = {
        user_id: 'UserId',
        password: 'Password',
        first_name: 'FirstName',
        last_name: 'LastName',
        email: 'Email',
        phone: 'Phone',
        ssn: 'SocialSecurityNumber',
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

    attr_reader :session

    def initialize(attributes = {}, session = AqumulateAPI.session)
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
      @session = session
    end

    def self.find(id, session = AqumulateAPI.session)
      response = AggAdvisor.get_advisor_by_id({ 'CEUserID' => id }, session)

      advisor = new({}, session)
      advisor.first_name = response['AdvisorName'].split(' ').first
      advisor.last_name = response['AdvisorName'].split(' ').last
      advisor.email = response['AdvisorEmail']
      advisor.ce_user_id = id

      return advisor
    end

    def self.all(session = AqumulateAPI.session)
      response = AggAdvisor.get_advisors
      return [] unless response.has_key?('AdvisorList')
      response['AdvisorList'].map { |source|  from_source(source, session) }
    end

    def self.from_source(source, session)
      advisor = new({}, session)

      ATTR_MAP.invert.each do |k, v|
        advisor.send("#{v.to_s}=", source[k])
      end

      advisor
    end

    def save
      if ce_user_id.nil?
        create
      else
        update
      end
    end

    def destroy
      AggAdvisor.delete_advisor({ 'UserID' => user_id, 'CEUserId' => ce_user_id })
      return true
    end

    private

    def create
      response = AggAdvisor.add_advisor(params)
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