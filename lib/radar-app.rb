require "radar/app/version"
require 'analyzer_controller'
require 'radar-api'

module RadarApp
  class Server
    def self.start
      handler = RadarApp::AnalyzerController.new
      processor = Radar::API::AnalyzerController::Processor.new(handler)
      transport = Thrift::ServerSocket.new(5000)
      transportFactory = Thrift::BufferedTransportFactory.new
      server = Thrift::ThreadedServer.new(processor, transport)
      puts "Starting server..."
      server.serve()
    end
  end
end
