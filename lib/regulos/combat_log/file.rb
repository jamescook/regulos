module Regulos
  module CombatLog
    class FileNotFoundError < RuntimeError; end
    # Helper for .new
    def CombatLog.parse(path)
      File.new( :path => path )
    end

    class File
      include Enumerable

      attr_reader :path, :io, :events
      def initialize(options={})
        @path   = ::File.exist?( options[:path] ) ? options[:path] : raise(FileNotFoundError, "The specified combat log does not exist.")
        @io     = ::File.open path, "r"
        @events = EventCollection.new []
      end

      def inspect
        "<Regulos::CombatLog::File path=#{@path}>"
      end
      
      def each
        io.each do |e|
          yield Event::Base.which(e)
        end
      end

      def next &block
        res = detect &block
        io.rewind
        res
      end

      def next! &block
        detect &block
      end
    end
  end
end
