module Regulos
  module CombatLog
    module Event
      class DebuffFade < Base
        def debuff?; true; end
      end
    end
  end
end
