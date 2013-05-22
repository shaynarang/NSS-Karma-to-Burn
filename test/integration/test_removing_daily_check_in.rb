require_relative '../test_helper'

class TestRemovingDailyCheckIn < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_remove_only_daily_check_in
    DailyCheckIn.create( user_id: 13 )
    `ruby ktb remove_daily 13`
    assert DailyCheckIn.all.empty?
  end

  def test_remove_particular_daily_check_in
    date = "2013-05-22"
    DailyCheckIn.create( date: date, user_id: 1)
    DailyCheckIn.create( date: date, user_id: 2)
    DailyCheckIn.create( date: date, user_id: 3)
    assert !DailyCheckIn.where( user_id: 2 ).all.empty?
    `ruby ktb remove_daily 2`
    assert DailyCheckIn.where( user_id: '2').all.empty?
    assert_equal 2, DailyCheckIn.count
  end

  def test_remove_particular_daily_check_in_doesnt_remove_all
    date = "2013-05-22"
    assert DailyCheckIn.all.empty?
    DailyCheckIn.create( date: date, user_id: 1)
    DailyCheckIn.create( date: date, user_id: 2)
    DailyCheckIn.create( date: date, user_id: 3)
    assert !DailyCheckIn.where( user_id: 2 ).all.empty?
    `ruby ktb remove_daily 1`
    assert_equal 2, DailyCheckIn.count
  end
end