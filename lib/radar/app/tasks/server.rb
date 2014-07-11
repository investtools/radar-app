module Radar
  module App
    module Tasks
      class Server < Thor::Group
        include Thor::Actions
        namespace :server

        def start_server
          require 'radar-app'
          Radar::App::Bootstrap.startup
        end
      end
    end
  end
end
