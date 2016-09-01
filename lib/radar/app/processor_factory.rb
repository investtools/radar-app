require 'thrift/exceptions'

module Radar
  module App
    module ProcessorFactory
      def self.create_processor(superclass)
        Class.new(superclass) do
          def write_error(err, oprot, name, seqid)
            super
            raise if err.type == Thrift::ApplicationException::INTERNAL_ERROR
          end
        end
      end
    end
  end
end
