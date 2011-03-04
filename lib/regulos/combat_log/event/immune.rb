module Regulos
  module CombatLog
    module Event
      class Immune < Base
        def immune?; true; end
      end
    end
  end
end
