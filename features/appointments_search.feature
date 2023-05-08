Feature: Appointments Search

  Scenario: Doctor Search Verification
    Given I click on doctor Search
    When I search the doctor by name
    Then I verify that the searched doctor is populated or not
    Then I clicked on the searched doctor
    Then I verify the recently selected doctor
    Then I verify top 10 popular specialties