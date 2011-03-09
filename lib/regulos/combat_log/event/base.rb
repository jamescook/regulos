require "digest/md5"

module Regulos
  module CombatLog
    module Event
      CODES = { 
              :Unknown        => "-1",
              :BeginCast      => "1",
              :Interrupt      => "2",
              :AttackHit      => "3",
              :DamageOverTime => "4",
              :Heal           => "5", 
              :BuffGain       => "6",
              :BuffFade       => "7",
              :DebuffGain     => "8",
              :DebuffFade     => "9",
              :AttackMiss     => "10",
              :Death          => "11",
              :UnknownDeath   => "12",
              :FallDamage     => "14",
              :Dodge          => "15",
              :Parry          => "16",
              :CriticalHit    => "23",
              :Immune         => "26",
              :ManaGain       => "27",
              :CriticalHeal   => "28"
      }
      def Event.handle row
        Base.which(row)
      end

      # An event represents a row in the combat log.
      class Base
        def initialize(attributes)
          process attributes
        end

        def inspect
          "<#{self.class} id=#{id}>"
        end

        def to_s
           respond_to?(:full_message) ? full_message : inspect
        end

        def is_a? thing
          if thing.is_a?(Symbol)
            thing.to_s.downcase == name.downcase
          else
            super
          end
        end

        def is_not? thing
          !is_a?(thing)
        end

        def targets thing
          target && target.is_a?(thing)
        end

        def originates thing
          origin && origin.is_a?(thing)
        end
        alias_method :origin_is, :originates

        def is_event?
          true
        end

        def id
          @id ||= Digest::MD5.hexdigest( [time, full_message].join ) if time && full_message
        end

        def ==(other)
          other.id == id
        end
        alias :eql? :==

        def <=> other
          time.to_s <=> other.time.to_s
        end

        def name
          self.class.to_s.split("::").last
        end

        def code
          CODES.invert[ action_code ]
        end

        def target_is_player?
          target && target.klass == "Player"
        end

        def target_is_npc?
          target && target.klass == "Npc"
        end

        def origin_is_npc?
          origin && origin.klass == "Npc"
        end

        def origin_is_player?
          origin && origin.klass == "Player"
        end

        def origin_is_pet?
          origin && origin.klass == "Pet"
        end

        def target_is_pet?
          target && target.klass == "Pet"
        end

        def miss?;     false; end
        def parry?;    false; end
        def dodge?;    false; end
        def resist?;   false; end
        def immune?;   false; end
        def attack?;   false; end
        def spell?;    false; end
        def heal?;     false; end
        def overheal?; false; end
        def buff?;     false; end
        def debuff?;   false; end
        def critical?; false; end
        def death?;    false; end
        def damage_over_time?; false; end

        def process attributes
          attributes.each_pair{|k,v| self.class.send(:attr_reader, k); instance_variable_set("@#{k}", v) }
        end

        protected

        class << self
          def which(row)
            require "strscan"
            return row if row.class.to_s =~ /Event\Z/i
            s = StringScanner.new row   
#03:53:35: ( 15 , T=N#R=O#9223372038886130583 , T=N#R=O#9223372043800556153 , T=X#R=X#224054081475471412 , T=X#R=X#0 , Lesser Earth Elemental , Eternal Servant , 0 , 75533189 , Thud ) Eternal Servant dodges Lesser Earth Elemental's Thud.
            entity_regex  = /\s[A-Z]=[A-Z]#[A-Z]=[A-Z]#\d+?\s,/
            e = {}
            e[:time]         = s.scan(/\d{2}:\d{2}:\d{2}:\s\(/)  # Time of action
            e[:action_code]  = s.scan(/\s\d+?\s,/)               # 15 (dodge)
            e[:origin]       = s.scan entity_regex
            e[:target]       = s.scan entity_regex
            e[:pet_origin]   = s.scan entity_regex               # Your pet did something
            e[:pet_target]   = s.scan entity_regex               # Your pet is receiving damage, heal, etc
            e[:origin_name]  = s.scan /\s[A-Za-z\s\-]+?\s,/
            e[:target_name]  = s.scan /\s[A-Za-z\s\-]+?\s,/
            e[:output]       = s.scan /\s\d+?\s,/                # Damage or healing output
            e[:spell_id]     = s.scan /\s\d+?\s,/                # Spell ID
            e[:spell_name]   = s.scan /\s[A-Za-z\-\s]+?\s\)/     # Spell name
            e[:full_message] = s.scan /\s(.*)+\Z/                # Full log message
            e = sanitize(e)
            e = capture_entities(e)
            determine_event_type(e).new e
          end

          def capture_entities(hash)
            CombatLog::Entity::Base.process(hash)
          end

          def sanitize hash
            hash.each_pair do |k,v|
              v.to_s.strip!                # Remove leading space
              v.to_s.gsub! /[,\(\)]\Z/, '' # Then remove leading comma or parenthesis
              v.to_s.gsub! /\A[,\(\)]/, '' # Then remove trailing comma or parenthesis
              v.to_s.strip!                # Then remove trailing space
              hash[k] = v
            end

            hash
          end

          def determine_event_type hash
            kind = CODES.invert.fetch(hash[:action_code]){ "Unknown" }
            Regulos::CombatLog::Event.const_get "#{kind}"
          end
        end
      end
    end
  end
end
