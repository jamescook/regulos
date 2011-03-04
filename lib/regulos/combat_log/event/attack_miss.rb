module Regulos
  module CombatLog
    module Event
      class AttackMiss < Base
        def miss?;   true; end
        def attack?; true; end
      end
    end
  end
end
