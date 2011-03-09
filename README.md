# Regulos

### 'Rift - Planes of Telera' combat log parser


#### How to Install

* gem install regulos


#### Usage

* require 'regulos'
* log = Regulos::CombatLog::File.new :path => "/path/to/combatlog.txt"
* log.read
* # Find all events that are heals that both target and originate from a player.
* log.select do |e| 
*   e.heal?               \
*     and                 \
*   e.targets :player     \
*     and                 \
*   e.origin_is :player
* end

#### Notes
The parser attempts to be as 'lazy' as possible. It does not read the entire file into memory, rather, it reads as needed.

#### Methods on Event
  time, action_code, origin, target, origin_name, target_name, output, spell_id, spell_name, full_message

### TODO
- End of combat markers are not handled.
- Pet detection is surely broken.
- More convience methods for searching events, such as 'pvp?'
- Make file parsing smart in that events are grouped per end-of-combat marker
 


Author: James Cook
