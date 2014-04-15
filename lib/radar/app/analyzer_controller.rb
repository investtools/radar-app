module Radar
  module App
    class AnalyzerController
      attr_reader :sessions

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

      def on_each_day(session_id, portfolio)
        handle_error do
          @sessions[session_id].on_each_day(portfolio)
        end
      end

      def on_each_month(session_id, portfolio)
        handle_error do
          @sessions[session_id].on_each_month(portfolio)
        end
      end

      def on_finish(session_id, portfolio)
        handle_error do
          @sessions[session_id].on_finish(portfolio)
        end
      end

      def create_session(session_id, analyzer_id)
        handle_error do
          analyzer = @@analyzers[analyzer_id].new
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