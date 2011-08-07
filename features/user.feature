Feature: Manage user accounts

  Scenario: Create a new user
    When I am on the home page
    And I create an account for user "David"
    Then I should be logged in as "David"

  Scenario: Login to existing account
    Given I have a user account for "David"
    When I am on the home page
    And I login as "David"
    Then I should be logged in as "David"
