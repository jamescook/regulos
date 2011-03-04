module Regulos
  module CombatLog
    module Event
      class Heal < Base
        def heal?; true; end
      end
    end
  end
end
