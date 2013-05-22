require_relative '../test_helper'

class TestRemovingAllDailyCheckIns < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_remove_all_DailyCheckIns
  	date = 2013-05-22
    DailyCheckIn.create( date: date, user_id: 1 )
    DailyCheckIn.create( date: date, user_id: 2 )
    DailyCheckIn.create( date: date, user_id: 3 )
    assert_equal 3, DailyCheckIn.count
    `ruby ktb remove_all_daily`
    assert DailyCheckIn.all.empty?
  end

end