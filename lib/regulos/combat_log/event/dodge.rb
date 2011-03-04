module Regulos
  module CombatLog
    module Event
      class Dodge < Base
        def attack?; true; end
      end
    end
  end
end
