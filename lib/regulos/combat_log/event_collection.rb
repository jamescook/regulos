require "delegate"
module Regulos
  module CombatLog
    class EventCollection < Array
      class FilterException < RuntimeError;end

      attr_reader :events

      def initialize(events=[])
        @events = events
        super(@events)
      end

      def inspect
        "<#{self.class} size=#{size}"
      end

      # Search the collection
      # e.g. :only => {:event => ["Heal", "BuffGain"]}
      # e.g. :only => {:target => [:player]}  #NYI
      def filter(options={})
        if options[:only] && options[:exclude] 
          raise FilterException, "You can't specify both 'only' and 'exclude'."
        end

        return only(options[:only])       if options[:only]
        return exclude(options[:exclude]) if options[:exclude]
      end

      protected
      def only(options)
        filter_events(:only, options[:event])    if options[:event]
      end

      def exclude(options)
        filter_events(:exclude, options[:event]) if options[:event]
      end

      def filter_events mode, keys
        mode = mode == :only ? :select : :reject
        EventCollection.new send(mode){|e| keys.include?(e.name) }
      end
    end
  end
end
