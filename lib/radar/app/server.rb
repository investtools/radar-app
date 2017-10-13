require 'radar-api'

module Radar
  module App
    class Server < Struct.new(:port)

      include Radar::App::Logger
      
      def start
        multiplexer = Thrift::MultiplexedProcessor.new
        analyzer_controller = Radar::App::AnalyzerController.new
        multiplexer.register_processor(
          'PortfolioAnalyzer',
          ProcessorFactory.create_processor(Radar::API::AnalyzerController::Processor).
            new(analyzer_controller)
        )
        unless Radar::App.transaction_importer.nil?
          multiplexer.register_processor(
            'TransactionImporter',
            ProcessorFactory.create_processor(Radar::API::TransactionImporter::Processor).
              new(Radar::App.transaction_importer)
          )
        end
        unless Radar::App.transaction_file_importer.nil?
          multiplexer.register_processor(
            'TransactionFileImporter',
            ProcessorFactory.create_processor(Radar::API::TransactionFileImporter::Processor).
              new(Radar::App.transaction_file_importer)
          )
        end
        transport = Thrift::ServerSocket.new(port)
        server = Thrift::NonblockingServer.new(multiplexer, transport, Thrift::FramedTransportFactory.new)
        logger.info { "Starting app on port #{port}..." }
        server.serve
      end
    end
  end
end
