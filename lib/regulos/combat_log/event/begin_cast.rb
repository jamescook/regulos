module Regulos
  module CombatLog
    module Event
      class BeginCast < Base
        def spell?; true; end
      end
    end
  end
end
