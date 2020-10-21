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
    And the cell at [0,0] is closed
    And I want to guess at [0,0]
    When I try to guess at [0,0]
    And I should get a valid return

  Scenario: hitting a boat
    Given it's my turn to play
    And the cell at [0,0] is closed
    And it is ensured that the cell at [0,0] has a boat
    And I want to guess at [0,0]
    When I try to guess at [0,0]
    Then I should be informed that I hit a boat
    And my opponent's public board should be updated with that guess for [0,0]

  Scenario: missing a boat
    Given it's my turn to play
    And the cell at [9,9] is closed
    And it is ensured that the cell at [9,9] does not have a boat
    And I want to guess at [9,9]
    When I try to guess at [9,9]
    Then I should be informed that I hit the water
    And my opponent's public board should be updated with that guess for [9,9]

  Scenario: it's not my turn to play
    Given it's not my turn to play
    When I try to guess at any position
    Then I should be informed with an error saying that it's not my turn to play