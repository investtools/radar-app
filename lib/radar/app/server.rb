require 'radar-api'

module Radar
  module App
    class Server
      def self.start
        port = ENV['PORT'] || 5000
        handler = Radar::App::AnalyzerController.new
        processor = Radar::API::AnalyzerController::Processor.new(handler)
        transport = Thrift::ServerSocket.new(port)
        transportFactory = Thrift::BufferedTransportFactory.new
        server = Thrift::ThreadedServer.new(processor, transport)
        $stderr.puts "Starting server on port #{port}..."
        server.serve()
      end
    end
  end
end
