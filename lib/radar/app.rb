require 'radar/app/version'
require 'radar/app/core_ext'
require 'radar/app/logger'
require 'radar/app/session'
require 'radar/app/controller'
require 'radar/app/analyzer_controller'
require 'radar/app/server'
require 'radar/app/bootstrap'
require 'radar/app/analyzer'
require 'radar/app/processor_factory'

require 'radar-api'
require 'connection_pool'
require 'thrift_client'
require 'active_support/string_inquirer'
require 'active_support/inflector'

module Radar
  module App

    def self.transaction_importer
      @transaction_importer
    end

    def self.transaction_importer=(ti)
      @transaction_importer = ti
    end

    def self.env
      @env ||= ActiveSupport::StringInquirer.new(ENV['RADAR_ENV'] || 'development')
    end

    def self.security_service
      @security_service ||= connection_pool('SecurityService')
    end

    def self.fund_service
      @fund_service ||= connection_pool('FundService')
    end

    def self.index_service
      @index_service ||= connection_pool('IndexService')
    end

    protected

    def self.connection_pool(client_class)
      ConnectionPool.new { connection(client_class) }
    end

    def self.connection(service)
      ThriftClient.new(
        ActiveSupport::Inflector.constantize("Radar::API::#{service}::Client"),
        "#{host}:9790",
        multiplexed_protocol: service,
        protocol: Thrift::BinaryProtocolAccelerated,
        retries: 1,
        server_retry_period: 0
      )
    end

    def self.host
      ENV['DATA_SERVER_HOST'] || 'radar.data.1'
    end
  end
end
