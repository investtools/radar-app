module Thrift
  class Builder
    def initialize(clazz)
      @class = clazz
    end

    def build(attributes)
      @class.new.tap do |obj|
        attributes.each do |attribute, value|
          obj.send "#{attribute}=", build_attr(@class::FIELDS[obj.name_to_id(attribute.to_s)], value)
        end
      end
    end

    protected

    def build_attr(field, value)
      case field[:type]
      when Thrift::Types::STRUCT
        Builder.new(field[:class]).build(value)
      when Thrift::Types::LIST
        value.map { |child| build_attr(field[:element], child) }
      when Thrift::Types::SET
        value.map { |child| build_attr(field[:element], child) }.to_set
      when Thrift::Types::I32
        if field.include?(:enum_class)
          field[:enum_class].const_get(value.upcase)
        else
          value
        end
      else
        value
      end
    end
  end
end
