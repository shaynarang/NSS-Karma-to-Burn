class UserController

  attr_accessor :params

  def initialize params
    @params = params
  end

  def add
    user = User.new(params[:user])
    if user.save
      puts "Success!"
    else
      puts "Failure: #{user.errors.full_messages.join(", ")}"
    end
  end

  def list
    users = User.all
    users.each_with_index do |user, i|
      puts "#{i+1}. #{user.name}"
    end
  end

  def remove
    matching_users = User.where(params[:user]).all
    matching_users.each do |user|
      user.destroy
    end
  end

  def remove_all
    users = User.all
    users.each do |user|
      user.destroy
    end
    puts "Success!" unless !User.all.empty?
  end

end