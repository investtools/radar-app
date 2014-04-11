require 'radar-api'

module Radar
  module App
    class Server
      def self.start
        handler = Radar::App::AnalyzerController.new
        processor = Radar::API::AnalyzerController::Processor.new(handler)
        transport = Thrift::ServerSocket.new(5000)
        transportFactory = Thrift::BufferedTransportFactory.new
        server = Thrift::ThreadedServer.new(processor, transport)
        puts "Starting server..."
        server.serve()
      end
    end
  end
end
