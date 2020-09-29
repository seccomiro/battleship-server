module Battleship
  class BoatPlacingError < StandardError
    attr_accessor :errors

    def initialize(errors)
      @errors = errors
      super
    end
  end

  class BoatRemovingError < StandardError
    def initialize
      super
    end
  end
end
