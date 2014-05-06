require 'active_support/concern'

module Radar
  module App
    module Controller
      
      extend ActiveSupport::Concern
      include Radar::App::Logger
      attr_reader :sessions

      def destroy_session(session_id)
        synchronized(session_id) do
          @sessions.delete(session_id)
        end
      end

      module ClassMethods

        protected

        def forward(*methods)
          methods.each do |method|
            define_method(method) do |session_id, *args|
              synchronized(session_id) do
                logger.debug { "[#{session_id}] #{method}(...)" }
                @sessions[session_id].analyzer.send(method, *args)
              end
            end
          end
        end
      end

      protected

      def synchronized(session_id)
        @sessions[session_id].mutex.synchronize { yield }
      end

    end
  end
end

