module Regulos
  module CombatLog
    module Event
      class UnknownDeath < Base
        def death?; true; end
      end
    end
  end
end
