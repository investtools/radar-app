module Radar
  module App
    class AnalyzerController
      attr_reader :sessions

      def initialize
        @sessions = {}
      end

      def analyzers
        @@analyzers.values.map { |analyzer_class| analyzer_class.new.config }
      end

      def self.register_analyzer(analyzer_id, analyzer_class)
        (@@analyzers ||= {})[analyzer_id] = analyzer_class
      end

      def on_each_day(session_id, portfolio)
        @sessions[session_id].on_each_day(portfolio)
      end

      def on_finish(session_id, portfolio)
        @sessions[session_id].on_finish(portfolio)
      end

      def create_session(session_id, analyzer_id)
        analyzer = @@analyzers[analyzer_id].new
        @sessions[session_id] = analyzer
        analyzer.config
      end

      def dump(session_id)
        @sessions[session_id].dump
      end

      def resume(session_id, data)
        @sessions[session_id].resume(data)
      end

      def result(session_id)
        handle_error do
          @sessions[session_id].result
        end
      end

      def destroy_session(session_id)
        @sessions.delete(session_id)
      end

      protected

      def handle_error
        begin
          yield
        rescue => e
          puts "#{e.class}: #{e.message}"
          puts e.backtrace
        end
      end
    end
  end
end