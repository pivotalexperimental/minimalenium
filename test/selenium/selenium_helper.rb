require File.dirname(__FILE__) + '/../test_helper'
require File.dirname(__FILE__) + '/selenium_driver_manager'

module Selenium
  module SeleniumHelper
    def browser
      SeleniumDriverManager.driver
    end
  end
end