Feature: player mounts a board with boats

  As a player
  I want to put my boats on a board
  So that I will be ready to begin a new match

  For now, there are only 3 predefined dimensions with their predefined boat list

  Scenario: get the boats to be distributed
    Given I have already created a board with dimensions <width> x <height>
    When I ask for the boats to be distributed
    Then I should receive the following boats to be distributed: <boats>
    Examples:
      | width | height | boats             |
      | 5     | 5      | "3,2,1"           |
      | 10    | 10     | "5,4,3,3,2"       |
      | 15    | 15     | "8,7,6,5,4,4,3,2" |
