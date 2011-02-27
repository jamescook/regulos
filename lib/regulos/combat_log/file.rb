module Regulos
  module CombatLog
    class FileNotFoundError < RuntimeError; end
    # Helper for .new
    def CombatLog.parse(path)
      log = File.new( :path => path )
      log.parse
      log
    end

    class File

      attr_reader :path, :events
      def initialize(options={})
        @path = ::File.exist?( options[:path] ) ? options[:path] : raise(FileNotFoundError, "The specified combat log does not exist.")
        @events = []
      end

      def parse
        data = ::File.readlines path
        data.each{|row| @events << Event.handle(row) }
      end

      def inspect
        "<Regulos::CombatLog::File path=#{@path}>"
      end
    end
  end
end
