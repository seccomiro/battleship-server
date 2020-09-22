Feature: player enters match

  As a player
  I want to enter a match with another player
  So that I can play against him

  Background: match already created
    Given a match already exists
    And the match is ready to be played by the players
    And I am a player named "Player 1"
    And my opponent is a player named "Player 2"

  Scenario: enter match
    Given two players are already attached to the match
    And I am not yet playing
    When I enter a match
    Then I should know that my sign in is confirmed
    And I should see "Welcome to Battleship"

  Scenario: the first to enter a match
    Given no players have joined a match yet
    When I enter a match
    Then I should see "Waiting for the other player"

  Scenario: the last to enter a match
    Given another player have already joined a match
    When I enter a match
    Then I should see "Your opponent is Player 2"
    And my opponent should see "Your opponent is Player 1"
