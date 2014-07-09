module Radar
  module App
    module Bootstrap
      def self.startup
        load_env_config
        load_app_config
        Radar::App::Server.new(ENV['PORT'] || 5000).start
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
    end
  end
end
