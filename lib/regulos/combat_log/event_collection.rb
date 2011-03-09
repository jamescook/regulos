require "set"

module Regulos
  module CombatLog
    class EventCollection < SortedSet
      alias_method :all, :select

      def initialize(events=[])
        @events = events
        super(events)
      end

      def events
        self
      end

      def [](index)
        if index && index.is_a?(Range)
          return EventCollection.new( to_a[index.begin, index.end] )
        else
          return to_a[index] 
        end
      end

      def select &block
        EventCollection.new( to_a.select(&block) )
      end

      def inspect
        "<#{self.class} size=#{size}"
      end

      def first
        to_a.first
      end

      def last
        to_a.last
      end
    end
  end
end
