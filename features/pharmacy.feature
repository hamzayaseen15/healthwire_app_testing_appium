Feature: Pharmacy
  
  Scenario: Order Medicine
    Given I click on order medicine button
    When I select the categories
    Then I click on search bar
    Then I Select two medicines from the search
    Then I Navigate back and click on view cart
    Then I verify the calculation on cart page
    Then I click on proceed to checkout button
    Then I select the address and scroll to the medicine information section
    Then I verify the medicine calculation
    Then I click on order now button to place order