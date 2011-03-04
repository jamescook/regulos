module Regulos
  module CombatLog
    module Event
      class BuffGain < Base
        def buff?; true; end
      end
    end
  end
end
