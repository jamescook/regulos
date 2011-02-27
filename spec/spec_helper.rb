require File.join(File.dirname(__FILE__), "..", "lib", "regulos.rb")

Spec::Runner.configure do |config|
  def simple_combat_log_path
    File.join( fixture_path, "simple_combat_log.txt" ) 
  end

   def fixture_path
     File.join( File.dirname(__FILE__), "fixtures" )
   end
end

