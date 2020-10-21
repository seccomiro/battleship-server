module Battleship
  class BoatPlacingError < StandardError
    attr_accessor :errors

    def initialize(errors)
      @errors = errors
      super
    end
  end

  class BoatRemovingError < StandardError
  end

  class MatchStartingError < StandardError
  end

  class PlayerAttachingError < StandardError
  end

  class CellNotAllowedError < StandardError
  end

  class OtherUserTurnError < StandardError
  end
end
