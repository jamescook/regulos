module Regulos
  module CombatLog
    module Event
      class DebuffGain < Base
        def debuff?; true; end
        def attack?; true; end
      end
    end
  end
end
