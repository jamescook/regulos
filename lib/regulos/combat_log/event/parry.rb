module Regulos
  module CombatLog
    module Event
      class Parry < Base
        def attack?; true; end
        def parry?; true; end
      end
    end
  end
end
