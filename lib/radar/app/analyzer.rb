module Radar
  module App
    module Analyzer
      def dump
        Marshal.dump(instance_variables.map { |v| [ v, instance_variable_get(v) ] })
      end

      def resume(data)
        Marshal.load(data).each do |name, value|
          instance_variable_set(name, value)
        end
      end
    end
  end
end
