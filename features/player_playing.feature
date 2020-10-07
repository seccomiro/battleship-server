Feature: player plays a match

  As a player that have already joined a match
  I want to play the game
  So that I can try to win it

  Background: players have already joined the match
    Given a match already exists
    And I am a player named "Player 1"
    And my opponent is a player named "Player 2"
    And both players have already joined the match

  Scenario: see my opponent's public board
    Given my opponent has a board
    When I ask the match for the public board
    Then I should receive his public board
    And all its cells should be closed

  Scenario: try a first guess
    Given I know my opponent's public board
    And it's my turn to play
    When I try to guess a closed cell
    And I should get a valid return

  Scenario: hitting a boat
    Given it's my turn to play
    And it is ensured that a closed cell has a boat
    When I try to guess a closed cell
    Then I should be informed that I hit a boat
    And my opponent's public board should be updated with that guess
