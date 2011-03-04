module Regulos
  module CombatLog
    module Event
      class CriticalHit < Base
        def attack?; true; end
        def critical?; true; end
      end
    end
  end
end
