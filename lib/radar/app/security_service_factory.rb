class Radar::App::SecurityServiceFactory
  def self.create
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new('127.0.0.1', 9790))
    protocol = Thrift::BinaryProtocol.new(transport)
    transport.open
    Radar::API::SecurityService::Client.new(protocol)
  end
end
