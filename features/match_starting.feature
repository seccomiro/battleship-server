Feature: match is starting

  Background: players have already joined the match
    Given a match already exists
    And I am a player named "Player 1"
    And my opponent is a player named "Player 2"
    And both players have already joined the match

  Scenario: draw the starting player
    When the match is asked to begin
    Then it should draw the starting player
    And the starting player should be one of the players attached to the match
    And the status of the match should be set to being played