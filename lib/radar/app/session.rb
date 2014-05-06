module Radar
  module App
    class Session < Struct.new(:analyzer)
      def mutex
        @mutex ||= Mutex.new
      end
    end
  end
end