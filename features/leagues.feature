Feature: Create and Join League
  Background: 
    Given A logged in user "David"

  Scenario: create a new league
    When I create a new league called "Default"
    Then I should have leagues:
      | MY LEAGUES      |
      | * Default 1 (1) |
      | Create League   |
      | All Leagues     |

  Scenario: create a new password protected league
    When I create a new league called "Password" with password "password"
    Then I should have leagues:
      | MY LEAGUES       |
      | * Password 1 (1) |
      | Create League    |
      | All Leagues      |

  Scenario: join a league
    Given a league called "Default"
    When I click leagues
    Then I should see leagues:
      | Name           | Members | Password |
      | Default (join) |       0 |       No |
    When I join league "Default"
    Then I should have leagues:
      | MY LEAGUES      |
      | * Default 1 (1) |
      | Create League   |
      | All Leagues     |

  Scenario: Must have correct password for password protected league
    Given a league called "PasswordLeague" with password "password"
    When I click leagues
    Then I should see leagues:
      | Name                  | Members | Password |
      | PasswordLeague (join) |       0 |      Yes |
    When I join league "PasswordLeague" with password ""
    Then I should have leagues:
      | MY LEAGUES      |
      | Create League   |
      | All Leagues     |
    And I have error message "Incorrect password" for "PasswordLeague"

  Scenario: Join password protected league
    Given a league called "PasswordLeague" with password "password"
    When I click leagues
    Then I should see leagues:
      | Name                  | Members | Password |
      | PasswordLeague (join) |       0 |      Yes |
    When I join league "PasswordLeague" with password "password"
    Then I should have leagues:
      | MY LEAGUES             |
      | * PasswordLeague 1 (1) |
      | Create League          |
      | All Leagues            |
