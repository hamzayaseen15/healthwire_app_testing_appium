Given(/^I click on doctor Search$/) do
  bookdoctor = @wait.until { @driver.find_element(:xpath, '/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.widget.FrameLayout[1]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ScrollView/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup[1]/android.widget.FrameLayout/android.view.ViewGroup/android.widget.ImageView[1]') }
  bookdoctor.click
  sleep(5)
  search_bar = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvSearchBar')
  search_bar_text = search_bar.text
  expect('Search for doctor or specialties here').to eq(search_bar_text)
  search_bar.click
end

When(/^I search the doctor by name$/) do
  doctor = ['Assist. Prof. Dr. Mujahid Israr', 'Dr. Asif Mehmood', 'Dr. Bilal Bin Mukhtar', 'Dr. Salman Javed',
            'Dr. Rabbia Ashraf', 'Dr. Fauzia Anjum', 'Dr. Kamran Ashraf Khan', 'Dr. Ali Kazmi', 'Dr. Sana Younas']
  @doctor_name = doctor.sample
  search_doctors = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/etDoctorSearch') }
  search_doctors.send_keys @doctor_name
  @driver.hide_keyboard
end

Then(/^I verify that the searched doctor is populated or not$/) do
  available_doctor = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvSearchedDoctor') }
  @searched_doctor = available_doctor.find_element(:id, 'com.healthwire.healthwire:id/constDoctors')
  @searched_doctor_name = @searched_doctor.find_element(:id, 'com.healthwire.healthwire:id/tvGeneralPhysicianDrName').text
  expect(@searched_doctor_name).to eq(@doctor_name)
end

Then(/^I clicked on the searched doctor$/) do
  @searched_doctor.click
end

Then(/^I verify the recently selected doctor$/) do
  2.times do
    @driver.navigate.back
  end  
  recent_search = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvRecentSearch') }
  recent_doctor = recent_search.find_elements(:id, 'com.healthwire.healthwire:id/constRecentSearch')[0]
  card_speciality = recent_doctor.find_element(:id, 'com.healthwire.healthwire:id/cardSpeciality')
  card_doctor_name = card_speciality.find_element(:id, 'com.healthwire.healthwire:id/tvGeneralPhysicianDrName').text
  expect(card_doctor_name).to eq(@searched_doctor_name)
end

Then(/^I verify top 10 popular specialties$/) do
  scroll_to_popular_speciality
  popular_specialties = ['Dentist', 'Hair Transplant Surgeon', 'Physiotherapist', 'Cosmetologist', 'Orthopedic Surgeon',
                         'Neurosurgeon', 'Gastroenterologist', 'General Surgeon', 'Nephrologist', 'Ophthalmologist']
  specialties = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvSpecialities') }
  specialties_name = specialties.find_elements(:id, 'com.healthwire.healthwire:id/tvName')
  specialties_name.each do |specialties_each_name|
    specialties_names = specialties_each_name.text
    if popular_specialties.include?(specialties_names)
      puts "#{specialties_names} is present in popular_specialties"
    else
      puts "#{specialties_names} is not present in popular_specialties"
    end
  end
  scroll_to_end
  specialties_end = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvSpecialities') }
  specialties_name_end = specialties_end.find_elements(:id, 'com.healthwire.healthwire:id/tvName')
  specialties_name_end.each do |specialties_each_name_end|
    specialties_names_end = specialties_each_name_end.text
    if popular_specialties.include?(specialties_names_end)
      puts "#{specialties_names_end} is present in popular_specialties"
    else
      puts "#{specialties_names_end} is not present in popular_specialties"
    end
  end
end

def scroll_to_popular_speciality
  @driver.swipe(start_x: 297, start_y: 870, end_x: 318, end_y: 300, duration: 500)
end

def scroll_to_end
  @driver.swipe(start_x: 297, start_y: 1449, end_x: 318, end_y: 300, duration: 500)
end