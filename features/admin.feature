Feature: Admin User
  Scenario: Admin can enter results
    Given A logged in Admin user "David"
    And Match for yesterday
    When user enters results
    Then can see updated points

  Scenario: Non admin can not enter results
    Given A logged in user "David"
    And Match for yesterday
    Then user can not update results

