require 'test_helper'

class BakerTest < Test::Unit::TestCase
  context "compile" do
    should "have the method compile" do
      assert Baker.respond_to?(:compile)
    end
  end
  
end
