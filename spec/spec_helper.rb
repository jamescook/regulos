require File.join(File.dirname(__FILE__), "..", "lib", "regulos.rb")
require "yaml"

RSpec.configure do |config|
  def simple_combat_log_path
    File.join( fixture_path, "simple_combat_log.txt" ) 
  end

   def fixture_path
     File.join( File.dirname(__FILE__), "fixtures" )
   end
 
   def load_yaml_fixture(filename)
     YAML.load_file File.join(fixture_path, filename)
   end
end

