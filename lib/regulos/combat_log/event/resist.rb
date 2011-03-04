module Regulos
  module CombatLog
    module Event
      class Resist < Base
        def spell?; true; end
        def resist?; true; end
        def attack?; true; end
      end
    end
  end
end
