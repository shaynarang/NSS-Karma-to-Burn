require_relative '../test_helper'

class TestRemovingAllUsers < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_remove_all_users
    User.create( name: "a")
    User.create( name: 'b')
    User.create( name: 'c')
    assert_equal 3, User.count
    `ruby ktb remove_all`
    assert User.all.empty?
  end

end