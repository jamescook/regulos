module Regulos
  module CombatLog
    module Event
      class EndCast < Base
        def spell?; true; end
      end
    end
  end
end
