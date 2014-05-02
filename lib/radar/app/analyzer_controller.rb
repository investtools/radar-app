module Radar
  module App
    class AnalyzerController
      include Radar::App::Controller
      attr_reader :sessions

      forward :on_each_month, :on_each_day, :on_finish, :on_cash_flow

      def initialize
        @sessions = {}
      end

      def analyzers
        handle_error do
          @@analyzers.values.map { |analyzer_class| analyzer_class.new.config }
        end
      end

      def self.register_analyzer(analyzer_id, analyzer_class)
        (@@analyzers ||= {})[analyzer_id] = analyzer_class
      end

      def create_session(session_id, analyzer_id)
        handle_error do
          analyzer = create_fresh_analyzer(@@analyzers[analyzer_id].name)
          @sessions[session_id] = analyzer
          analyzer.config
        end
      end

      def dump(session_id)
        handle_error do
          @sessions[session_id].dump
        end
      end

      def resume(session_id, data)
        handle_error do
          @sessions[session_id].resume(data)
        end
      end

      def result(session_id)
        handle_error do
          @sessions[session_id].result
        end
      end

      def destroy_session(session_id)
        handle_error do
          @sessions.delete(session_id)
        end
      end

      def example_result(session_id)
        handle_error do
          @sessions[session_id].example_result
        end
      end

      protected

      def create_fresh_analyzer(class_name)
        ActiveSupport::DescendantsTracker.clear
        ActiveSupport::Dependencies.clear
        Object.const_get(class_name).new
      end
    end
  end
end