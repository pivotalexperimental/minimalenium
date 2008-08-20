require File.dirname(__FILE__) + '/selenium_helper'

module Selenium
  class TestCase < Test::Unit::TestCase
    include Selenium::SeleniumHelper
  end
end