module Regulos
  module CombatLog
    module Event
      class AttackHit < Base
        def attack?; true; end
      end
    end
  end
end
