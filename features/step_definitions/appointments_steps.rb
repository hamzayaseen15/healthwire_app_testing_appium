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
  sleep(3)
end

Then(/^I select any random speciality$/) do
  el25 = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvMostChosenSpecialities') }
  child_of_el25 = @wait.until { el25.find_elements(:class, 'android.widget.TextView') }
  random_el25 = @wait.until { rand(0..child_of_el25.length - 1) }
  select_specialities = @wait.until { child_of_el25[random_el25] }
  @select_specialities_name = @wait.until { select_specialities.text }
  puts @select_specialities_name
  select_specialities.click
  sleep(4)
end

Then(/^I verify that selected speciality is open or not$/) do
  screen_heading = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvScreenHeading') }
  screen_heading_name = @wait.until { screen_heading.text }
  puts screen_heading_name
  expect(@select_specialities_name).to eq(screen_heading_name)
end

Then(/^I select the doctor to book an appointment$/) do
  doctor = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvDoctorsList') }
  @doctorname = doctor.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorName').text
  @practice_name = doctor.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorSpeciality').text
  @doctor_fee = doctor.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorFee').text.gsub('Rs. ','').to_i
  @doctor_speciality = doctor.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorSpecialist').text
end

Then(/^I click on view profile of selected doctor$/) do
  view_profile = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnDoctorViewProfile') }
  view_profile.click
end

Then(/^I verify the information of doctor in view profile page$/) do
  doctorname_profile = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorName').text }
  practice_name_profile = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvPractice').text
  doctor_speciality_profille = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorSpecialist').text
  # doctor_fee_profile = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDoctorFee').text.gsub('Rs ','').to_i
  expect(doctorname_profile).to eq(@doctorname)
  expect(practice_name_profile).to eq(@practice_name)
  expect(doctor_speciality_profille).to eq(@doctor_speciality)
  # expect(doctor_fee_profile).to eq(@doctor_fee)
end
