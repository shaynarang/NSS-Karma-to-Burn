class DailyCheckIn < ActiveRecord::Base
  attr_accessor :current_daily_check_in
  has_one :user
end
