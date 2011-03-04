require "delegate"
module Regulos
  module CombatLog
    class EventCollection < Array
      class FilterException < RuntimeError;end

      attr_reader :events

      def initialize(events=[])
        @events = events
        super(events)
      end

      def inspect
        "<#{self.class} size=#{size}"
      end
    end
  end
end
