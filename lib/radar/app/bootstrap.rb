module Radar
  module App
    module Bootstrap
      def self.startup
        require 'radar-app'
        load_env_config
        load_app_config
        load_initializers
      end

      protected

      def self.load_env_config
        require env_config if File.exist?(env_config)
      end

      def self.env_config
        "./config/#{Radar::App.env}.rb"
      end

      def self.load_app_config
        require './config/app.rb'
      end

      def self.load_initializers
        Dir['./config/initializers/**/*.rb'].each { |f| require f }
      end
    end
  end
end
