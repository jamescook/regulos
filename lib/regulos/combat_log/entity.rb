lib = File.expand_path('../', __FILE__)
$:.unshift lib unless $:.include?(lib)
require "entity/base"

entity_path   = File.join(lib, "entity" )
glob_pattern = entity_path + "/**/*.rb"
Dir.glob( glob_pattern ).each do |file|
  require file
end
