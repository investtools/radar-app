require 'thrift'
require 'radar-api'

module Radar
  module App
    module Tasks
      class Status < Thor::Group
        include Thor::Actions
        namespace :status

        def status
          transport = Thrift::FramedTransport.new(Thrift::Socket.new('127.0.0.1', ENV['PORT'] || 5000))
          protocol = Thrift::MultiplexedProtocol.new(Thrift::BinaryProtocolAccelerated.new(transport), 'Healthz')
          client = Radar::API::Healthz::Client.new(protocol)
          begin
            transport.open
            client.status
          rescue Thrift::TransportException => e
            case e.type
            when 1
              puts "Server is down!"
            else
              puts "Server is not ready: #{e}"
            end
            exit 100 + e.type
          end
          puts "Server is up!"
        end
      end
    end
  end
end
