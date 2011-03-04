module Regulos
  module CombatLog
    module Entity
      class Base
        NIL_ENTITY = 'T=X#R=X#0'
        attr_reader :guid, :name
        def initialize options={}
          @guid, @name = [ options[:guid], options[:name] ]
        end

        def inspect
          "<#{self.class} '#{name}'>"
        end

        def klass
          self.class.to_s.split("::").last
        end

        class << self
          #T=N#R=O#9223372043800556155
          #T=P#R=G#224054081475467319
          def process hash
            hash[:origin]     = determine_entity(hash[:origin],     hash[:origin_name])
            hash[:target]     = determine_entity(hash[:target],     hash[:target_name])
            hash[:pet_origin] = determine_entity(hash[:pet_origin], hash[:origin_name], true)
            hash[:pet_target] = determine_entity(hash[:pet_target], hash[:target_name], true)
            hash
          end

          def determine_entity flags_and_guid, name, pet=false
            return nil if flags_and_guid == NIL_ENTITY || flags_and_guid.nil?
            flags = flags_and_guid[0..8]
            guid  = flags_and_guid[9..-1]

            entity_code = flags[2]  #N,P,X
            group_code  = flags[6]  #O,G,R  # solo, group, & raid NYI
            case entity_code
              when 'N' then
                klass = Npc
              when 'P' then
                klass = pet ? Pet : Player
              when 'X' then
                klass = Unknown
              else
                klass = Unknown
            end
            klass.new(:guid => guid, :name => name)
          end
        end
      end
    end
  end
end
