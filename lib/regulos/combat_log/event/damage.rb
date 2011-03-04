module Regulos
  module CombatLog
    module Event
      class Damage < Base
        def attack?; true; end
      end
    end
  end
end
