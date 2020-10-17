Feature: player plays a match

  As a player playing a match
  I want to make my final guess
  So that I will win it

  Background: a match is ready to be won
    Given the board of both players has only one closed public cell remaining

  Scenario: winning a match
    And it's my turn to play
    When I guess at the closed cell
    Then I should be the winner of the match
    And the match should have the status set to finished
