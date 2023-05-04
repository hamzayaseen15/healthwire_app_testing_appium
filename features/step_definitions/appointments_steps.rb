Given(/^I Complete the quick tour$/) do
  5.times do
    quicktour = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnTutorial') }
    quicktour.click
  end
end

When(/^I login to the application$/) do
  username = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/etUserName') }
  username.click
  username.send_keys 'Test'
  phonenumber = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/etPhoneNumber') }
  phonenumber.send_keys '3331157897'
  login = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnGenerateOtp') }
  login.click
end

Then(/^I click on Book Doctor Appointment$/) do
  bookdoctor = @wait.until { @driver.find_element(:xpath, '/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ImageView[1]') }
  bookdoctor.click
  sleep(5)
end

Then(/^I select any random speciality$/) do
  el25 = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvMostChosenSpecialities') }
  child_of_el25 = @wait.until { el25.find_elements(:class, 'android.widget.TextView') }
  random_el25 = @wait.until { rand(0..child_of_el25.length - 1) }
  select_specialities = @wait.until { child_of_el25[random_el25] }
  @select_specialities_name = @wait.until { select_specialities.text }
  puts @select_specialities_name
  select_specialities.click
  sleep(10)
end

Then(/^I verify that selected speciality is open or not$/) do
  screen_heading = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvScreenHeading') }
  screen_heading_name = @wait.until { screen_heading.text }
  puts screen_heading_name
  expect(@select_specialities_name).to eq(screen_heading_name)
end

Then(/^I select the doctor to book an appointment$/) do
  doctor = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvDoctorsList') }
  $doctorname = doctor.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorName').text
  @practice_name = doctor.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorSpeciality').text
  $doctor_fee = doctor.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorFee').text.gsub('Rs. ','').to_i
  @doctor_speciality = doctor.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorSpecialist').text
end

Then(/^I click on view profile of selected doctor$/) do
  view_profile = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnDoctorViewProfile') }
  view_profile.click
  sleep(10)
end

Then(/^I verify the information of doctor in view profile page$/) do
  doctorname_profile = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorName').text }
  practice_name_profile = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvPractice').text
  doctor_speciality_profille = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorSpecialist').text
  # doctor_fee_profile = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorFee').text.gsub('Rs ','').to_i
  expect($doctorname).to eq(doctorname_profile)
  expect(@practice_name).to eq(practice_name_profile)
  expect(@doctor_speciality).to eq(doctor_speciality_profille)
  # expect(doctor_fee_profile).to eq(@doctor_fee)
end

Then(/^I click on book appointment button$/) do
  book_appointment_profile = @driver.find_element(:id, 'com.healthwire.healthwire:id/btnViewWeeklyCalender')
  book_appointment_profile.click
  sleep(5)
end

Then(/^I choose day on review appointment page$/) do
  day = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvWeekDays') }
  choose_day = @wait.until { day.find_elements(:id, 'com.healthwire.healthwire:id/tvDayName') }
  day_length = choose_day.length - 1
  random_choose_day = @wait.until { rand(0..day_length) }
  select_day = @wait.until { choose_day[random_choose_day] }
  @selected_day = select_day.text
  puts @selected_day
  select_day.click
  sleep(5)
end

Then(/^I choose time on review appointment page$/) do
  slots = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvSlotsDivisionDivision') }
  choose_slots = @wait.until { slots.find_elements(:id, 'com.healthwire.healthwire:id/slotTime') }
  slots_length = choose_slots.length - 1
  if slots_length.positive?
    random_choose_slots = @wait.until { rand(0..slots_length) }
    select_slots = @wait.until { choose_slots[random_choose_slots] }
    @selected_time = select_slots.text
    puts @selected_time
    select_slots.click
  end
end

Then(/^I verify the selected day and time on bottom$/) do
  $bottom_date = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDate').text
  $bottom_time = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvTime').text
  expect($bottom_date).to eq(@selected_day)
  expect($bottom_time).to eq(@selected_time)
end

Then(/^I click on review appointment button$/) do
  review_appointment = @driver.find_element(:id, 'com.healthwire.healthwire:id/btnBookAppointment')
  review_appointment.click
end

Then(/^I verify information on review page$/) do  
  review_name = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorName').text }
  review_fee = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvBookingTotalFee').text.gsub('Rs. ', '').to_i
  review_date = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDateTime').text
  review_time = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvAppointmentDetails').text
  review_subtotal = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvTime').text.gsub('Rs. ', '').to_i
  expect(review_name).to eq($doctorname)
  expect(review_fee).to eq($doctor_fee)
  expect(review_subtotal).to eq($doctor_fee)
  expect(review_date).to eq($bottom_date)
  expect(review_time).to eq($bottom_time)
end

Then(/^I click on book appointment$/) do
  book_appointment = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnBookAppointment') }
  book_appointment.click
end

Then(/^I reschedule the appointment$/) do
  reschedule = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnReschedule') }
  reschedule.click
  sleep(3)
  slots_reschedule = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvSlotsDivisionDivision') }
  choose_slots_reschedule = @wait.until { slots_reschedule.find_elements(:id, 'com.healthwire.healthwire:id/slotParent') }
  slots_length_reschedule = @wait.until { choose_slots_reschedule.length - 1 }
  random_choose_slots_reschedule = @wait.until { rand(0..slots_length_reschedule) }
  select_slots_reschedule = @wait.until { choose_slots_reschedule[random_choose_slots_reschedule] }
  select_slots_reschedule.click
end

Then(/^I click on review and book appointment button$/) do
  2.times do
    book_appointment = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnBookAppointment') }
    book_appointment.click
  end
end

Then(/^I cancel the appointment$/) do
  cancel = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnCancel') }
  cancel.click
end
