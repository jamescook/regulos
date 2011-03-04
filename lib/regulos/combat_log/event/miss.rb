module Regulos
  module CombatLog
    module Event
      class Miss < Base
        def attack?; true; end
      end
    end
  end
end
