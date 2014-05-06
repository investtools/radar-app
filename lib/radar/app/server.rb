require 'radar-api'

module Radar
  module App
    class Server
      def self.start
        port = ENV['PORT'] || 5000
        handler = Radar::App::AnalyzerController.new
        processor = Radar::API::AnalyzerController::Processor.new(handler)
        transport = Thrift::ServerSocket.new(port)
        server = Thrift::NonblockingServer.new(processor, transport, Thrift::FramedTransportFactory.new)
        $stderr.puts "Starting app on port #{port}..."
        server.serve
      end
    end
  end
end
