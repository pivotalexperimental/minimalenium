require File.dirname(__FILE__) + '/selenium_helper'
 
class PostTest < SeleniumTest
  include SeleniumHelper
  
  def test_post
    browser.open "/posts"
    assert_equal "Posts: index", browser.get_title
    assert browser.is_text_present(posts(:one).title)
    assert browser.is_text_present(posts(:two).body)
  end
end