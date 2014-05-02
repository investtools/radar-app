require 'active_support/concern'

module Radar
  module App
    module Controller
      
      extend ActiveSupport::Concern

      module ClassMethods

        protected

        def forward(*methods)
          methods.each do |method|
            define_method(method) do |session_id, *args|
              handle_error do
                @sessions[session_id].send(method, *args)
              end
            end
          end
        end
      end

      protected

      def handle_error
        begin
          yield
        rescue => e
          $stderr.puts "#{e.class}: #{e.message}"
          $stderr.puts e.backtrace
          $stderr.puts
        end
      end
    end
  end
end

