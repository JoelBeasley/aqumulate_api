module AqumulateAPI
  class Entity

    ATTR_MAP = {}
    SOURCE_ASSOCIATIONS = []

    def initialize(attributes = {})
      attributes.each { |k, v| instance_variable_set("@#{k}", v) }
    end

    def self.from_source(source)
      entity = new({})

      self::ATTR_MAP.invert.each do |k, v|
        entity.send("#{v.to_s}=", source[k])
      end

      self::SOURCE_ASSOCIATIONS.each do |association|
        association_set = entity.send(association[:attr])

        source[association[:key]].each do |association_source|
          association_set << association[:class].from_source(association_source)
        end

        entity.send("#{association[:attr].to_s}=", association_set)
      end

      entity
    end

  end
end