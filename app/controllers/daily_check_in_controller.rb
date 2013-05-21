class DailyCheckInController

  attr_accessor :daily_params

  def initialize daily_params
    @daily_params = daily_params
  end

  def list
    daily_check_ins = DailyCheckIn.all
    daily_check_ins.each_with_index do |daily_check_in, i|
      puts "#{i+1}. #{daily_check_in.date}"
    end
  end

  def remove
    matching_daily_check_ins = DailyCheckIn.where(daily_params[:daily_check_in]).all
    matching_daily_check_ins.each do |daily_check_in|
      daily_check_in.destroy
    end
  end

  def remove_all
    daily_check_ins = DailyCheckIn.all
    daily_check_ins.each do |daily_check_in|
      daily_check_in.destroy
    end
    puts "Success!" unless !DailyCheckIn.all.empty?
  end

end