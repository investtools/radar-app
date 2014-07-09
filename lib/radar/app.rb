require 'radar/app/version'
require 'radar/app/core_ext'
require 'radar/app/logger'
require 'radar/app/session'
require 'radar/app/controller'
require 'radar/app/analyzer_controller'
require 'radar/app/server'
require 'radar/app/bootstrap'

require 'radar-api'
require 'connection_pool'
require 'thrift_client'
require 'active_support/string_inquirer'

module Radar
  module App
    def self.env
      @env ||= ActiveSupport::StringInquirer.new(ENV['RADAR_ENV'] || 'development')
    end

    def self.security_service
      @security_service ||= connection_pool(Radar::API::SecurityService::Client, 9790)
    end

    def self.fund_service
      @fund_service ||= connection_pool(Radar::API::FundService::Client, 9791)
    end

    def self.index_service
      @index_service ||= connection_pool(Radar::API::IndexService::Client, 9792)
    end

    protected

    def self.connection_pool(client_class, port)
      ConnectionPool.new { connection(client_class, port) }
    end

    def self.connection(client_class, port)
      ThriftClient.new(client_class, "#{host}:#{port}",
        protocol: Thrift::BinaryProtocolAccelerated, retries: 1, server_retry_period: 0)
    end

    def self.host
      ENV['DATA_SERVER_HOST'] || '127.0.0.1'
    end
  end
end
