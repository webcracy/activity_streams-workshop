require 'test_helper'

class ActivityTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Activity.new.valid?
  end
end
