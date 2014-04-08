class Radar::App::IndexServiceFactory
  def self.create
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new('127.0.0.1', 9792))
    protocol = Thrift::BinaryProtocol.new(transport)
    transport.open
    Radar::API::IndexService::Client.new(protocol)
  end
end
