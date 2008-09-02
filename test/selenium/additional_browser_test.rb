require File.dirname(__FILE__) + '/../test_helper'
require 'selenium-rails'

class AdditionalBrowserTest < Selenium::TestCase
  fixtures :all
  
  def test_additional_browser_post
    additional_browser.open "/posts"
    assert_equal "Posts: index", additional_browser.get_title
    assert additional_browser.is_text_present(posts(:one).title)
    assert additional_browser.is_text_present(posts(:two).body)
  end
  
  def additional_browser
    @additional_browser ||= Selenium::SeleniumDriverManager.driver(:browser_url => 'http://127.0.0.1:3001')
  end
end