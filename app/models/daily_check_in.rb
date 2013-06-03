class DailyCheckIn < ActiveRecord::Base
  attr_accessor :current_daily_check_in
  has_one :user

  def self.date
    time = Time.new
    month = time.month
    day = time.day
    "#{time.year}-#{"%02d" % month}-#{"%02d" % day}"
  end

end
