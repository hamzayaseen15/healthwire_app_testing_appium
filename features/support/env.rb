require 'appium_lib'
require 'rspec'

Before do | scenario |
  # need to configure env variables for browser
  options = {
    caps: {
      "platformName": 'android',
      "deviceName": 'Z5R4J7IBQKPZL7X4',
      "appPackage": 'com.healthwire.healthwire',
      "appActivity": 'com.healthwire.healthwire.ui.activities.SplashActivity',
      "automationName": 'UiAutomator2',
      "noReset": 'true',
      "autoAcceptAlerts": 'false',
      "newCommandTimeout": '5000'
    },
    appium_lib: {
      server_url: 'http://127.0.0.1:4723/wd/hub'
    }
  }

  @driver = Appium::Driver.new(options, true)
  @driver.start_driver
  @wait = Selenium::WebDriver::Wait.new(timeout: 30)
end

After do |scenario|
  sessionid = @driver.session_id
  # @driver.driver_quit
end
