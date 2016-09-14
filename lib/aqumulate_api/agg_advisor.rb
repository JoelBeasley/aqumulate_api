module AqumulateAPI
  class AggAdvisor
    RESOURCE = 'AggAdvisor'
  end

  AggAdvisor.singleton_class.class_eval do
    methods = {
        get_advisors: { method: 'GetAdvisors' },
        add_advisor: { method: 'AddAdvisor' },
        advisor_sign_on: { method: 'AdvisorSignOn' },
        get_advisor_by_id: { method: 'GetAdvisorById' },
        update_advisor: { method: 'UpdateAdvisor' },
        delete_advisor: { method: 'DeleteAdvisor' },
    }

    methods.each do |method, definition|
      define_method(method) do |body = {}, session = AqumulateAPI.session|
        session.api_request("#{self::RESOURCE}/#{definition[:method]}", body)
      end
    end
  end
end