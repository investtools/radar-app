require 'radar/app/bootstrap'

module Radar
  module App
    module Tasks
      class Console < Thor::Group
        include Thor::Actions
        namespace :console

        def start_console
          Radar::App::Bootstrap.startup
          if Object.const_defined?('Pry')
            Pry.start(nil, commands: pry_commands)
          else
            IRB.start
          end
        end

        protected

        def pry_commands
          Pry::CommandSet.new do
            command 'reload!', 'Reload the app classes' do
              puts 'Reloading...'
              $class_reloader.execute_if_updated
            end
          end
        end
      end
    end
  end
end
