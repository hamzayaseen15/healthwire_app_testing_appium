Given /^I click on order medicine button$/ do
  el1 = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/pharmacyDashboard') }
  el1.click
end

When /^I select the categories$/ do
  sleep(5)
  el2 = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvHealthProductsByCategories') }
  top_med_ctg = @wait.until { el2.find_elements(:id, 'com.healthwire.healthwire:id/mainLayout') }
  random_top_med_ctg = @wait.until { rand(0..top_med_ctg.length - 1) }
  select_category = @wait.until { top_med_ctg[random_top_med_ctg] }
  select_category.click
end

Then /^I click on search bar$/ do
  search_medicine = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvSearchBar') }
  search_medicine.click
  sleep(3)
  @driver.hide_keyboard
end

Then /^I Select first medicine from the search$/ do
  select_medicine
  medicine_information = @select_random_med.find_elements(:class, 'android.widget.TextView')
  if medicine_information[2].text == '/pack'
    btn_addcart_click = @wait.until { @select_random_med.find_element(:class, 'android.widget.Button') }
    btn_addcart_click.click
    add_quantity
  else
    btn_addcart_click_strip = @wait.until { @select_random_med.find_element(:class, 'android.widget.Button') }
    btn_addcart_click_strip.click
    selected_pack_size = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/radioGroupStripPack') }
    pack_strip = @wait.until { selected_pack_size.find_elements(:class, 'android.widget.RadioButton') }
    random_pack_strip = @wait.until { rand(0..pack_strip.length - 1) }
    select_pack_strip = @wait.until { pack_strip[random_pack_strip] }
    select_pack_strip.click
    add_quantity
    add_cart = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnDone') }
    add_cart.click
  end
end

Then /^I Select another medicine from the search$/ do
  select_medicine
  medicine_information = @select_random_med.find_elements(:class, 'android.widget.TextView')
  if medicine_information[2].text == '/pack'
    btn_addcart_click = @wait.until { @select_random_med.find_element(:class, 'android.widget.Button') }
    btn_addcart_click.click
    add_quantity
  else
    btn_addcart_click_strip = @wait.until { @select_random_med.find_element(:class, 'android.widget.Button') }
    btn_addcart_click_strip.click
    selected_pack_size = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/radioGroupStripPack') }
    pack_strip = @wait.until { selected_pack_size.find_elements(:class, 'android.widget.RadioButton') }
    random_pack_strip = @wait.until { rand(0..pack_strip.length - 1) }
    select_pack_strip = @wait.until { pack_strip[random_pack_strip] }
    select_pack_strip.click
    add_quantity
    add_cart = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnDone') }
    add_cart.click
  end
end

def select_medicine
  medicines_all = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvGenericList') }
  medicine = @wait.until { medicines_all.find_elements(:id, 'com.healthwire.healthwire:id/mainLayout') }
  random_medicine = @wait.until { rand(0..medicine.length - 1) }
  @select_random_med = @wait.until { medicine[random_medicine] }
end

def add_quantity
  rand_qc_new = rand(1..7)
  rand_qc_new.times do
    quantity_count_strip = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvQuantity') }
    qc_strip = quantity_count_strip.text
    quantity_plus_strip = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/ivPlus') }
    quantity_plus_strip.click
    sleep(4)
    quantity_count_new_strip = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvQuantity') }
    qc_new_strip = quantity_count_new_strip.text
    break if qc_strip == qc_new_strip
  end
end