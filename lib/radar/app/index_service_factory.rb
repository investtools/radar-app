class Radar::App::IndexServiceFactory
  def self.create
    host = ENV['RADAR_HOST'] || '127.0.0.1'
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, 9792))
    protocol = Thrift::BinaryProtocol.new(transport)
    transport.open
    Radar::API::IndexService::Client.new(protocol)
  end
end
