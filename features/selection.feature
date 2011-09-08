Feature: Select goal difference for team
  Background: 
    Given A logged in user "David"

  Scenario: Can edit a future matche
    Given Match for tomorrow
    When I select a goal difference of Home by "10"
    Then I have selections of Home by "10"

  Scenario: Can not edit a match for today
    Given Match for today
    Then can not select a goal difference for the match
