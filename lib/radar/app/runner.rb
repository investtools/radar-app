require 'bundler/setup'
require 'thor'
require 'radar/app/tasks'

module Radar
  module App
    class Runner < Thor
      register(Radar::App::Tasks::New, :new, 'new APP', 'Create a new app')
      register(Radar::App::Tasks::Generate, :generate, 'generate TYPE', 'Generate source files')
      register(Radar::App::Tasks::Server, :server, 'server', 'Start the app server')
    end
  end
end
