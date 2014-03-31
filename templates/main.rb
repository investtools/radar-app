require 'radar-app'
require 'radar-api'
require './registry_analyzers'

handler = RadarApp::AnalyzerController.new
processor = Radar::API::AnalyzerController::Processor.new(handler)
transport = Thrift::ServerSocket.new(5000)
transportFactory = Thrift::BufferedTransportFactory.new
server = Thrift::ThreadedServer.new(processor, transport)
puts "Starting server..."
server.serve()
