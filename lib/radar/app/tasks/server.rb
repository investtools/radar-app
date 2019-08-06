require 'sigdump'

module Radar
  module App
    module Tasks
      class Server < Thor::Group
        include Thor::Actions
        namespace :server

        def start_server
          Sigdump.setup('TTIN', '-')
          Radar::App::Bootstrap.startup
          Radar::App::Server.new(ENV['PORT'] || 5000).start
        end
      end
    end
  end
end
