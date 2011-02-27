lib = File.expand_path('../', __FILE__)
$:.unshift lib unless $:.include?(lib)
require "event/base"

event_path   = File.join(lib, "event" )
glob_pattern = event_path + "/**/*.rb"
Dir.glob( glob_pattern ).each do |file|
  require file
end
