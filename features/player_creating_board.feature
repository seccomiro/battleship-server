Feature: player creates a board

  As a user
  I want to create a new Board
  So that I will be a Player ready to begin a new match

  Background: user already exists
    Given I am a registered user

  Scenario: create a new board
    Given I have no staging board
    When I ask to create a new board with dimensions <width> x <height>
    Then I should receive an empty board with dimensions <width> x <height>
    Examples:
      | width | height |
      | 2     | 2      |
      | 2     | 5      |
      | 2     | 10     |
      | 5     | 2      |
      | 5     | 5      |
      | 5     | 10     |
      | 10    | 2      |
      | 10    | 5      |
      | 10    | 10     |
