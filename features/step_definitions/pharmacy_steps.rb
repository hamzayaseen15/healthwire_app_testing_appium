Given(/^I click on order medicine button$/) do
  el1 = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/pharmacyDashboard') }
  el1.click
  sleep(5)
end

Then(/^I add the address on google map$/) do
  google_map = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnSave') }
  google_map.click
end

When(/^I select the categories$/) do
  sleep(5)
  el2 = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvHealthProductsByCategories') }
  top_med_ctg = @wait.until { el2.find_elements(:id, 'com.healthwire.healthwire:id/mainLayout') }
  random_top_med_ctg = @wait.until { rand(0..top_med_ctg.length - 1) }
  select_category =  @wait.until { top_med_ctg[random_top_med_ctg] }
  select_category.click
end

Then(/^I click on search bar$/) do
  search_medicine = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvSearchBar') }
  search_medicine.click
  sleep(3)
  @driver.hide_keyboard
end

Then(/^I Select two medicines from the search$/) do
  select_medicine
end

Then(/^I Navigate back and click on view cart$/) do
  @driver.navigate.back
  view_cart = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvViewCartText') }
  view_cart.click
end

Then(/^I verify the calculation on cart page$/) do
  cart_calculation
  sleep(3)
  subtotal_amount = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvSubTotalAmount').text.gsub('Rs. ', '').to_f
  delivery_charges = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDeliveryChargesAmount').text.gsub('Rs. ', '').to_f
  medicine_dis_amount = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvMedicinesDiscountAmount').text.gsub('Rs. -', '').to_f
  total = @driver.find_element(:id, 'com.healthwire.healthwire:id/totalOrderAmountBottomBar').text.gsub('Rs. ', '').to_f
  expect($subtotal.to_i).to eq(subtotal_amount.to_i)
  expect($discount.to_i).to eq(medicine_dis_amount.to_i)
  expect($delivery).to eq(delivery_charges)
  expect($t.to_i).to eq(total.to_i)
end

Then(/^I click on proceed to checkout button$/) do
  sleep(5)
  checkout = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnProceedToCheckout') }
  checkout.click
end

Then(/^I select the address and scroll to the medicine information section$/) do
  address = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvChangeShippingAddressText') }
  if address.text == 'Update Address'
    @driver
      .action
      .move_to_location(310, 1137)
      .pointer_down(:left)
      .move_to_location(317, 407)
      .release
      .perform
  else
    address.click
    add_address = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rbAddress') }
    add_address.click
    address_save = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnDone') }
    address_save.click
    @driver
      .action
      .move_to_location(310, 1137)
      .pointer_down(:left)
      .move_to_location(317, 407)
      .release
      .perform
    sleep(4)
  end
end

Then(/^I verify the medicine calculation$/) do
  subtotal_amount_checkout = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvSubTotalAmount').text.gsub('Rs. ', '').to_f
  delivery_charges_checkout = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvDeliveryChargesAmount').text.gsub('Rs. ', '').to_f
  medicine_dis_amount_checkout = @driver.find_element(:id, 'com.healthwire.healthwire:id/tvMedicinesDiscountAmount').text.gsub('Rs. -', '').to_f
  total_checkout = @driver.find_element(:id, 'com.healthwire.healthwire:id/totalOrderAmountBottomBar').text.gsub('Rs. ', '').to_f
  expect($subtotal.to_i).to eq(subtotal_amount_checkout.to_i)
  expect($discount.to_i).to eq(medicine_dis_amount_checkout.to_i)
  expect($delivery).to eq(delivery_charges_checkout)
  expect($t.to_i).to eq(total_checkout.to_i)
end

Then(/^I click on order now button to place order$/) do
  order_now = wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnOrderNow') }
  order_now.click
end

def select_medicine
  prev_random_medicine = 0
  2.times do
    medicines_all = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/rvGenericList') }
    medicine = @wait.until { medicines_all.find_elements(:id, 'com.healthwire.healthwire:id/mainLayout') }
    random_medicine = 0
    while random_medicine == prev_random_medicine
      random_medicine = @wait.until { rand(0..medicine.length - 2) }
    end
    select_random_med = @wait.until { medicine[random_medicine] }
    @medicine_information = select_random_med.find_elements(:class, 'android.widget.TextView')
    if @medicine_information[2].text == '/pack'
      btn_addcart_click = @wait.until { select_random_med.find_element(:class, 'android.widget.Button') }
      btn_addcart_click.click
      sleep(2)
      rand_qc = rand(1..7)
      rand_qc.times do
        quantity_count = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvQuantity') }
        qc = quantity_count.text
        quantity_plus = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/ivPlus') }
        quantity_plus.click
        sleep(2)
        quantity_count_new = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvQuantity') }
        qc_new = quantity_count_new.text
        break if qc == qc_new
      end
    else
      btn_addcart_click_strip = @wait.until { select_random_med.find_element(:class, 'android.widget.Button') }
      btn_addcart_click_strip.click
      selected_pack_size = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/radioGroupStripPack') }
      pack_strip = @wait.until { selected_pack_size.find_elements(:class, 'android.widget.RadioButton') }
      # random_pack_strip = @wait.until { rand(0..pack_strip.length - 1) }
      random_pack_strip = 1
      select_pack_strip = @wait.until { pack_strip[random_pack_strip] }
      select_pack_strip.click
      rand_qc_new = rand(1..7)
      rand_qc_new.times do
        quantity_count_strip = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvQuantity') }
        qc_strip = quantity_count_strip.text
        quantity_plus_strip = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/ivPlus') }
        quantity_plus_strip.click
        quantity_count_new_strip = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/tvQuantity') }
        qc_new_strip = quantity_count_new_strip.text
        break if qc_strip == qc_new_strip
      end
      add_cart = @wait.until { @driver.find_element(:id, 'com.healthwire.healthwire:id/btnDone') }
      add_cart.click
    end
    prev_random_medicine = random_medicine
  end
end

def cart_calculation
  sleep(4)
  cart = @driver.find_element(:id, 'com.healthwire.healthwire:id/rvSlowMovingItems')
  total_medicines_cart = cart.find_elements(:id, 'com.healthwire.healthwire:id/mainLayout')
  medicines = []
  total_discounted_price = 0
  total_actual_price = 0

  total_medicines_cart.each do |element|
    each_medicine_info = element.find_elements(:class, 'android.widget.TextView')
    medicine_name = each_medicine_info[0].text
    discounted_price = each_medicine_info[1].text.gsub('Rs. ', '').to_f
    actual_price = each_medicine_info[2].text.gsub('Rs. ', '').to_f
    if actual_price.zero?
      actual_price = discounted_price
    end
    size = each_medicine_info[3].text
    if size != 'Pack' && size != 'Strip'
      quantity = each_medicine_info[3].text.to_i
    else
      quantity = each_medicine_info[4].text.to_i
    end

    total_discounted_price += discounted_price * quantity
    total_actual_price += actual_price * quantity

    medicine_info = {
      name: medicine_name,
      discounted_price: discounted_price,
      actual_price: actual_price,
      size: size,
      quantity: quantity
    }
    medicines << medicine_info
  end
  $subtotal = total_actual_price
  $discount = total_actual_price - total_discounted_price
  $delivery = 99
  $t = $subtotal - $discount + $delivery
end
