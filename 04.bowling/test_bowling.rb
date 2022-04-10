require 'minitest/autorun'

class BowlingTest < Minitest::Test
  def test_bowling
    assert_equal "139\n", `./bowling.rb 6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5`
    assert_equal "164\n", `./bowling.rb 6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X`
    assert_equal "107\n", `./bowling.rb 0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4`
    assert_equal "134\n", `./bowling.rb 6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0`
    assert_equal "144\n", `./bowling.rb 6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8`
    assert_equal "300\n", `./bowling.rb X,X,X,X,X,X,X,X,X,X,X,X`
  end
end
