module Regulos
  module CombatLog
    module Event
      class Interrupt < Base
        def spell?; true; end
      end
    end
  end
end
