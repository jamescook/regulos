module Regulos
  module CombatLog
    module Event
      class Death < Base
        def death?; true; end
      end
    end
  end
end
