Feature: player enters match

  As a player
  I want to enter a match with another player
  So that I can play against him

  Background: match already created
    Given a match already exists
    And the match is ready to be played by the players

  Scenario: enter match
    Given two players are already attached to the match
    And I am not yet playing
    When I enter a match
    Then I should know that my sign in is confirmed
    And I should see "Welcome to Battleship"

  Scenario: the first to enter a match
    Given I entered a match
    When I am the first player to enter the match
    Then I should see "Waiting for the other player"

  # Scenario: the last to enter a match
  #   Given I am not yet playing
  #   When I enter a match
  #   And I should see "Your opponent is"
  #   And I shouldn't see "Waiting for the other player"