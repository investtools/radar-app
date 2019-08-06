require 'radar/app/runner'
require 'radar/app'
require 'socket'

describe Radar::App::Tasks::Status do
  describe '#status' do
    let(:port) do
      server = TCPServer.new('127.0.0.1', 0)
      port = server.addr[1]
      server.close
      port
    end
    before :each do
      allow(ENV).to receive(:[]).and_return nil
      allow(ENV).to receive(:[]).with('PORT').and_return port
    end
    it 'exits with error code when cannot connect to server' do
      expect { Radar::App::Runner.start(%w{status}) }.to raise_error SystemExit
    end
    it 'does not exit with error when PONG is received' do
      Thread.new { @server = Radar::App::Server.new(port).start }
      sleep 0.3
      expect { Radar::App::Runner.start(%w{status}) }.not_to raise_error
    end
  end
end
