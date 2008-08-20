require File.dirname(__FILE__) + '/../test_helper'
require 'selenium'

module Selenium
  module SeleniumHelper
    def browser
      SeleniumDriverManager.driver
    end
  end

  class SeleniumDriverManager
    cattr_accessor :selenium_driver
  
    def self.driver(driver_options = {})
      unless @@selenium_driver
        browser_start_command = ENV['BROWSER_START_COMMAND'] ? ENV['BROWSER_START_COMMAND'] : '*firefox'
        opts = {:server_host => 'localhost', :server_port => '4444', :browser_start_command => browser_start_command, 
                :browser_url => 'http://localhost:3001', :timeout => 10000}.merge(driver_options)
        @@selenium_driver = Selenium::SeleniumDriver.new(opts[:server_host], opts[:server_port], opts[:browser_start_command],
                                     opts[:browser_url], opts[:timeout])
        @@selenium_driver.start
      end
      @@selenium_driver
    end

    def self.stop_driver
      @@selenium_driver.stop if @@selenium_driver
      @@selenium_driver = nil
    end
  end

  class SeleniumTestCase < Test::Unit::TestCase
    include SeleniumHelper

    def setup
      super
    end
  
    def default_test
    end
  end
end

module SeleniumRails
  class ServersRunner
    def self.run_with_servers(&block)
      begin
        rails_server_process = IO.popen("ruby #{File.dirname(__FILE__) }/../../script/server --port=3001")
        selenium_server = Selenium::SeleniumServer.new
        unless selenium_server.running?
          selenium_server_process = IO.popen("selenium")
        end

        yield

        Selenium::SeleniumDriverManager.stop_driver
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
  end
  
  class SeleniumRailsTestCase < Selenium::SeleniumTestCase
    fixtures :all  
  end
end