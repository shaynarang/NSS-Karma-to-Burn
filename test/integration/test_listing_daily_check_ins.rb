require_relative '../test_helper'

class TestListingDailyCheckIns < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_listing_when_there_are_no_daily_check_ins
    assert DailyCheckIn.all.empty?
    actual = `ruby ktb list_daily`
    assert_equal "", actual
  end

  def test_listing_multiple_daily_check_ins
    time = Time.new
    date = "2013-05-22"
    DailyCheckIn.create(date: date, user_id: 1)
    DailyCheckIn.create(date: date, user_id: 2)
    DailyCheckIn.create(date: date, user_id: 3)
    actual = `ruby ktb list_daily`
    expected = <<EOS
1. #{date} user_id: 1
2. #{date} user_id: 2
3. #{date} user_id: 3
EOS
    assert_equal expected, actual
  end

end