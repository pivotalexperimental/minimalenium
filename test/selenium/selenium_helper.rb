require File.dirname(__FILE__) + '/../test_helper'
require 'selenium'

module Selenium
  module SeleniumHelper
    def browser
      SeleniumBrowser.browser
    end
  end

  class SeleniumBrowser
    cattr_reader :selenium_driver
  
    def self.browser
      unless @@selenium_driver
        @@selenium_driver = Selenium::SeleniumDriver.new("localhost", 4444, "*firefox", "http://localhost:3001", 10000)
        @@selenium_driver.start
      end
      @@selenium_driver
    end

    def self.stop_browser
      @@selenium_driver.stop if @@selenium_driver
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
  class SeleniumRailsTestCase < Selenium::SeleniumTestCase
    fixtures :all  
  end
end