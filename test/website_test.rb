require 'test_helper'

class WebsiteTest < TestCase
  def test_homepage
    get '/'
    assert last_response.ok?
  end
end
