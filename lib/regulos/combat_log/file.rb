# ############################ #
# Regulos - Combat log parser  #
# ############################ #
#
# f = Regulos::CombatLog::File.new :path => "/Users/jamecook/Downloads/CombatLog.txt"
# f.read  # Read all events, not required
# f.first
# f.first{|event| event.is_a?(:heal) }
# See Event::Base for the various methods that can be used for filtering. 
# 

module Regulos
  module CombatLog
    class FileNotFoundError < RuntimeError; end

    class File < ::File

      attr_reader :path, :events, :debug
      def initialize(options={})
        @path   = File.exist?( options[:path] ) ? options[:path] : raise(FileNotFoundError, "The specified combat log does not exist.")
        @events = EventCollection.new []
        super(@path)
      end

      def inspect
        "<Regulos::CombatLog::File path=#{@path}>"
      end
      
      # Pass the block onto the collection set for searching
      # e.g. select{|event| event.is_a?(:heal) }
      def each &block
        if eof?
          @events.instance_eval do
            each &block
          end
        else
          trap("INT"){ rewind; break } # if you SIGINT mid search, future searches will be goofed until eof is 
                                       # reached due to the lazy nature of this block.
          each_line do |e|
            parsed   = Event::Base.which(e)
            @events << parsed
            STDERR.write("\r-> Reading (#{pos}) '#{parsed.name}'        ") if debug?
            yield parsed
          end
        end
      end

      def select &block
        EventCollection.new super
      end

      def size
        @size || read.size
      end

      # Resets the event collection and re-parse the log.
      def reload
        @events.clear
        read
      end

      def read
        readlines.map{|line| @events << Event::Base.which(line) }
        if eof?
          @size = @events.size
        end
        @events
      end

      def first &block
        if block_given?
          detect &block
        else
          @events.first || detect{|e| e.is_event? }
        end
      end

      # Reverse the set and pluck the first match. This requires the entire file to be parsed (yikes).
      def last &block
        read unless eof?
        if block_given?
          EventCollection.new(@events.to_a.reverse).detect &block
        else
          @events[-1]
        end
      end

      # Enable debugging, which currently prints parsing information during a search.
      def debug!; @debug=true; end
      def debug?; @debug; end
    end
  end
end
