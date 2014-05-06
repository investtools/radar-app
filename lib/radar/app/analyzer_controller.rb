module Radar
  module App
    class AnalyzerController
      include Radar::App::Controller

      forward :on_each_month, :on_each_day, :on_finish,
      :on_cash_flow, :dump, :resume, :result

      def initialize
        @sessions = {}
      end

      def analyzers
        registry.values.map { |analyzer_class| Object.const_get(analyzer_class).new.config }
      end

      def self.<<(analyzer_class)
        registry[analyzer_class.new.config.id] = analyzer_class.name
      end

      def create_session(session_id, analyzer_id)
        analyzer = create_fresh_analyzer(analyzer_id)
        @sessions[session_id] = Session.new(analyzer)
        analyzer.config
      end

      def example_result(session_id)
        synchronized(session_id) do
          @sessions[session_id].analyzer.example_result
        end
      end

      protected

      def create_fresh_analyzer(analyzer_id)
        if Radar::App.env.development?
          $class_reloader.execute_if_updated
        end
        Object.const_get(registry[analyzer_id]).new
      end

      def registry
        self.class.registry
      end

      def self.registry
        (@@registry ||= {})
      end
    end
  end
end