require 'radar/app/version'
require 'radar/app/core_ext'
require 'radar/app/analyzer_controller'

require 'connection_pool'
require 'radar-api'

module Radar
  module App
    def self.security_service
      @security_service ||= connection_pool(Radar::API::Security::Client, 9790)
    end

    def self.index_service
      @index_service ||= connection_pool(Radar::API::FundService::Client, 9791)
    end

    def self.fund_service
      @fund_service ||= connection_pool(Radar::API::IndexService::Client, 9792)
    end

    protected

    def self.connection_pool(client_class, port)
      ConnectionPool.new { connection(client_class, port) }
    end

    def self.connection(client_class, port)
      host = ENV['DATA_SERVER_HOST'] || '127.0.0.1'
      transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, port))
      protocol = Thrift::BinaryProtocol.new(transport)
      transport.open
      client_class.new(protocol)
    end
  end
end
