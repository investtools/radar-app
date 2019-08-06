require 'bundler/setup'
require 'thor'
require 'radar/app/tasks'

module Radar
  module App
    class Runner < Thor
      register(Radar::App::Tasks::New, :new, 'new APP', 'Create a new app')
      register(Radar::App::Tasks::Generate, :generate, 'generate TYPE NAME', 'Generate source files')
      register(Radar::App::Tasks::Server, :server, 'server', 'Start the app server')
      register(Radar::App::Tasks::Status, :status, 'status', 'Check the server status')
      register(Radar::App::Tasks::Console, :console, 'console', 'Start the console for test')
    end
  end
end
