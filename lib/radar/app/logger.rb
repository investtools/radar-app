require 'active_support/concern'

module Radar
  module App

    def self.logger=(logger)
      @logger = logger
    end

    def self.logger
      @logger ||= ::Logger.new(STDERR)
    end

    module Logger

      extend ActiveSupport::Concern

      def logger
        Radar::App.logger
      end

      module ClassMethods
        def logger
          Radar::App.logger
        end
      end
    end
  end
end
