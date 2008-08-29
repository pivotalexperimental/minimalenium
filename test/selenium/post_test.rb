require File.dirname(__FILE__) + '/../test_helper'
require 'selenium-rails'

class PostTest < Selenium::TestCase
  fixtures :all
  
  def test_post_1_1
    browser.open "/posts"
    assert_equal "Posts: index", browser.get_title
    assert browser.is_text_present(posts(:one).title)
    assert browser.is_text_present(posts(:two).body)
  end

  def test_post_1_2
    browser.open "/posts"
    assert_equal "Posts: index", browser.get_title
    assert browser.is_text_present(posts(:one).title)
    assert browser.is_text_present(posts(:two).body)
  end
end