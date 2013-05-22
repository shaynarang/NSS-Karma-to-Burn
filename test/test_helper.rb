require 'test/unit'
require_relative '../bootstrap_ar'

connect_to 'test'
ENV['KTB_ENV'] = 'test'

module DatabaseCleaner
  def before_setup
    super
    User.destroy_all
    DailyCheckIn.destroy_all
  end
end