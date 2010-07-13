require 'test_helper'

class ActivityObjectTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ActivityObject.new.valid?
  end
end
