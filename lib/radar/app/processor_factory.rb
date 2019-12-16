require 'thrift/exceptions'
require 'radar-api'

module Radar
  module App
    module ProcessorFactory

      class AppErrorHandler
        def initialize(target)
          @target = target
        end

        def method_missing(m, *args, &block)
          begin
            @target.send(m, *args, &block)
          rescue => e
            if e.kind_of?(Thrift::Exception)
              raise e
            else
              raise Radar::API::ApplicationError.new(message: e.message, stacktrace: e.backtrace)
            end
          end
        end
      end

      def self.create_processor(superclass)
        Class.new(superclass) do
          def initialize(handler)
            super(AppErrorHandler.new(handler))
          end

          def write_error(err, oprot, name, seqid)
            super
            raise if err.type == Thrift::ApplicationException::INTERNAL_ERROR
          end
        end
      end
    end
  end
end
