require File.dirname(__FILE__) + '/../test_helper'
require 'selenium-rails'

class PostTwoTest < Selenium::TestCase
  fixtures :all
  
  def test_post_2_1
    browser.open "/posts"
    assert_equal "Posts: index", browser.get_title
    assert browser.is_text_present(posts(:one).title)
    assert browser.is_text_present(posts(:two).body)
  end

  def test_post_2_2
    browser.open "/posts"
    assert_equal "Posts: index", browser.get_title
    assert browser.is_text_present(posts(:one).title)
    assert browser.is_text_present(posts(:two).body)
  end
end