Feature: player mounts the board with his boats

  As a player
  I want to place my boats on a board
  So that I will be able to look for a new match

  Scenario: mount the board
    Given I have a board with dimensions <width> x <height>
    And I have a set of boats for that board
    When I place each boat side by side from the biggest to the smallest, beginning from the top-left
    Then my private board should be: <matrix>
    And there should be no boats left
    Examples:
      | width | height | matrix                                                                                                                                                                                                                                                                                                                                                                                                                                                              |
      | 5     | 5      | "b,b,b,w,w/b,b,w,w,w/b,w,w,w,w/w,w,w,w,w/w,w,w,w,w"                                                                                                                                                                                                                                                                                                                                                                                                                 |
      | 10    | 10     | "b,b,b,b,b,w,w,w,w,w/b,b,b,b,b,w,w,w,w,w/b,b,b,b,w,w,w,w,w,w/b,b,w,w,w,w,w,w,w,w/b,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w"                                                                                                                                                                                                                                                           |
      | 15    | 15     | "b,b,b,b,b,b,b,b,w,w,w,w,w,w,w/b,b,b,b,b,b,b,b,w,w,w,w,w,w,w/b,b,b,b,b,b,b,w,w,w,w,w,w,w,w/b,b,b,b,b,b,w,w,w,w,w,w,w,w,w/b,b,b,b,w,w,w,w,w,w,w,w,w,w,w/b,b,b,w,w,w,w,w,w,w,w,w,w,w,w/b,b,w,w,w,w,w,w,w,w,w,w,w,w,w/b,w,w,w,w,w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w,w,w,w,w,w/w,w,w,w,w,w,w,w,w,w,w,w,w,w,w" |

  Scenario: boat overlapping
    Given I have a board with dimensions 2 x 3
    And I have a first boat with size 2
    And I have a test boat with size 2
    And I have already placed the first boat
    When I try to place the next boat overlapping at least one of the cells of the first boat
    Then I should be informed about the problem with a feedback about the overlapping cells
    And the board should not change
    And the boat should not be placed

  Scenario: boat out of bounds
    Given I have a board with dimensions 2 x 2
    And I have a test boat with size 2
    When I try to place the boat from row <from_row>, column <from_column> and direction <direction>
    Then I should be informed about the problem with a feedback about the problematic cells
    And the board should not change
    And the boat should not be placed
    Examples:
      | from_row | from_column | direction    |
      | -1       | 0           | "vertical"   |
      | 1        | 0           | "vertical"   |
      | 0        | -1          | "horizontal" |
      | 0        | 1           | "horizontal" |
      | -2       | -2          | "vertical"   |
      | -2       | -2          | "horizontal" |
      | 2        | 2           | "vertical"   |
      | 2        | 2           | "horizontal" |

  Scenario: removing a placed boat
    Given I have a board with dimensions 2 x 2
    And I have a test boat with size 2
    And I have already placed the boat
    When I remove the boat from the board
    Then the cells where the boat were previously placed should be empty
    And the boat should not be placed
    And the placed boat count of the board should be 0