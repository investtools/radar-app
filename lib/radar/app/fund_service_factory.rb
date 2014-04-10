class Radar::App::FundServiceFactory
  def self.create
    host = ENV['RADAR_HOST'] || '127.0.0.1'
    transport = Thrift::BufferedTransport.new(Thrift::Socket.new(host, 9791))
    protocol = Thrift::BinaryProtocol.new(transport)
    transport.open
    Radar::API::FundService::Client.new(protocol)
  end
end
