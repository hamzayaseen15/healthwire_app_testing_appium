def run_tests(deviceName, platformName, platformVersion, app, autoAcceptAlerts)
  system("deviceName=\"#{deviceName}\" platformName=\"#{platformName}\" platformVersion=\"#{platformVersion}\" app=\"#{app}\" autoAcceptAlerts=\"#{autoAcceptAlerts}\" parallel_cucumber features -n 20")
end

task :Run_On_Device do
  run_tests('Z5R4J7IBQKPZL7X4', 'android','10','com.healthwire.healthwire', 'true')
end

multitask :test_healthwire => [:Run_On_Device]
