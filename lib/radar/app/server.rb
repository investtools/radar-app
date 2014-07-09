require 'radar-api'

module Radar
  module App
    class Server < Struct.new(:port)

      include Radar::App::Logger
      
      def start
        handler = Radar::App::AnalyzerController.new
        processor = Radar::API::AnalyzerController::Processor.new(handler)
        transport = Thrift::ServerSocket.new(port)
        server = Thrift::NonblockingServer.new(processor, transport, Thrift::FramedTransportFactory.new)
        logger.info { "Starting app on port #{port}..." }
        server.serve
      end
    end
  end
end
