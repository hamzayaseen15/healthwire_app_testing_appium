Feature: Appointments

  Scenario: Book Appointment
    Given I Complete the quick tour
    When I login to the application
    Then I click on Book Doctor Appointment
    Then I select any random speciality
    Then I verify that selected speciality is open or not
    Then I select the doctor to book an appointment
    Then I click on view profile of selected doctor
    Then I verify the information of doctor in view profile page
    Then I click on book appointment button
    Then I choose day on review appointment page
    Then I choose time on review appointment page
    Then I verify the selected day and time on bottom
    Then I click on review appointment button
    Then I verify information on review page
    Then I click on book appointment
    Then I reschedule the appointment
    Then I click on review and book appointment button
    Then I cancel the appointment

