require File.dirname(__FILE__) + '/../test_helper'
require 'selenium'

module SeleniumHelper
  def browser
    SeleniumBrowser.browser
  end
end

class SeleniumBrowser
  include SeleniumHelper
  
  def self.browser
    unless $browser
      $browser = Selenium::SeleniumDriver.new("localhost", 4444, "*firefox", "http://localhost:3001", 10000)
      $browser.start
    end
    $browser
  end

  def self.stop_browser
    $browser.stop if $browser
  end
end

class SeleniumTest < Test::Unit::TestCase
  include SeleniumHelper
  
  def setup
    super
  end
  
  def default_test
  end
end

