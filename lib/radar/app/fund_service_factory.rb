class Radar::App::FundServiceFactory
  def self.create
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new('127.0.0.1', 9791))
    protocol = Thrift::BinaryProtocol.new(transport)
    transport.open
    Radar::API::FundService::Client.new(protocol)
  end
end
