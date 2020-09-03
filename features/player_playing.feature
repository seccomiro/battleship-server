Feature: player enters match

  As a player
  I want to enter a match with another player
  So that I can play against him

  Scenario: enter match
    Given I am not yet playing
    When I enter a match
    Then I should see "Welcome to Battleship"

  Scenario: is the first to enter a match
    Given I am not yet playing
    When I enter a match
    And I should see "Waiting for the other player"
    And I shouldn't see "Your opponent is"

  Scenario: is the last to enter a match
    Given I am not yet playing
    When I enter a match
    And I should see "Your opponent is"
    And I shouldn't see "Waiting for the other player"