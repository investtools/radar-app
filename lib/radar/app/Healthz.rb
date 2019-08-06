module Radar
  module App
    class Healthz
      def status
        Radar::API::HealthStatus::HEALTHY
      end
    end
  end
end
