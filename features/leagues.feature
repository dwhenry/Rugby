Feature: Create and Join League
  Background: 
    Given A logged in user "David"

  Scenario: create a new league
    When I create a new league called "Default"
    Then I should have leagues:
      | MY LEAGUES    |
      | * Default     |
      | Create League |
      | All Leagues   |

  Scenario: create a new password protected league
    When I create a new league called "Password" with password "password"
    Then I should have leagues:
      | MY LEAGUES    |
      | * Password    |
      | Create League |
      | All Leagues   |

  Scenario: join a league
    Given a league called "Default"
    When I click leagues
    Then I should see leagues:
      | Name           | Members | Password |
      | Default (join) |       0 |       No |
    When I join league "Default"
    Then I should have leagues:
      | MY LEAGUES    |
      | * Default     |
      | Create League |
      | All Leagues   |
