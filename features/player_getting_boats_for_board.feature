Feature: player gets boats to be distributed

  As a player with a board
  I want to get the boats for that board
  So that I will be able to distribute them on the board

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
      | 7     | 8      | ""                |
