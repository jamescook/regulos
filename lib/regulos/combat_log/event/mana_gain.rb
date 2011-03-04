module Regulos
  module CombatLog
    module Event
      class ManaGain < Base
        def spell?; true; end
      end
    end
  end
end
