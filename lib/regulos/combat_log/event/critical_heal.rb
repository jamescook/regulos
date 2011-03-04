module Regulos
  module CombatLog
    module Event
      class CriticalHeal < Base
        def heal?; true; end
        def critical?; true; end
      end
    end
  end
end
