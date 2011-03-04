# Regulos

### 'Rift - Planes of Telera' combat log parser


#### How to Install

* gem install regulos


#### Usage

* require 'regulos'
* log = Regulos::CombatLog.parse "/path/to/combatlog.txt"
* log.find :event => {:only => ['Heal']}, :entity => [:player]


#### Methods on Event
  time, action_code, origin, target, origin_name, target_name, output, spell_id, spell_name, full_message
 


