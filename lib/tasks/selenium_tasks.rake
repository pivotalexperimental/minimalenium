require 'test/unit'

namespace :test do
  desc "Run tests for Selenium (automatically starts rails and selenium RC servers)"
  task :selenium do 
    begin
      # NOTE: must require selenium here instead of top of file, or else it will always set RAILS_ENV to test
      require File.dirname(__FILE__) + '/../../test/selenium/selenium_helper'
      rails_server_process = IO.popen("ruby #{File.dirname(__FILE__) }/../../script/server --port=3001")
      selenium_server = Selenium::SeleniumServer.new
      unless selenium_server.running?
        selenium_server_process = IO.popen("selenium")
      end

      Rake::Task["test:selenium_with_servers_started"].invoke
  
      SeleniumBrowser.stop_browser
    rescue Exception => e
      puts e
      raise e
    ensure
      puts "Killing rails server process at pid #{rails_server_process.pid}"
      Process.kill(9,rails_server_process.pid)
      puts "Killing selenium server"
      selenium_server.stop
    end
  end

  Rake::TestTask.new(:selenium_with_servers_started) do |t|
    t.pattern = 'test/selenium/**/*_test.rb'
    t.verbose = true
  end
end

