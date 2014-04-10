class Radar::App::SecurityServiceFactory
  def self.create
    host = ENV['RADAR_HOST'] || '127.0.0.1'
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, 9790))
    protocol = Thrift::BinaryProtocol.new(transport)
    transport.open
    Radar::API::SecurityService::Client.new(protocol)
  end
end
