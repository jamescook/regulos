module Regulos
  module CombatLog
    module Event
      class DamageOverTime < Base
        def damage_over_time?; true; end
        def attack?; true; end
      end
    end
  end
end
