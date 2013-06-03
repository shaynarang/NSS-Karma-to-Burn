require './bootstrap_ar'

class Program

  PHYSIOLOGICAL = ["Today, I ate nutritious foods from most, if not all, of the food groups.", "I got enough sleep last night."]
  SAFETY = ["I did not do anything reckless today. I acted with caution in my daily exploits.", "I did not injure myself today."]
  ESTEEM = ["I am proud of my accomplishments today.", "I look forward to the challenges that tomorrow will bring."]
  LOVE = ["Today, I attempted to spend time or communicate with people I care about.", "Today, the encounters I had with others were mostly positive."]
  TRANSCENDENCE = ["Today, I was curious about the world and my place in it.", "I learned something about myself today, even it is just a little."]

  def commentary(genre)
    insults = ["moron", "numb nuts", "dip shit", "idiot", "dummy", "fool", "cheese dick", "douche", "dick flap", "turd burgler", "scuzz bucket", "scumbag", "dunce", "lame", "ass", "dick weed", "dimwit", "butt puppet", "dumbass", "ass clown", "fail", "useless"]
    compliments = ["boss", "beast", "bonus", "rad", "righteous", "dope", "super", "wicked", "groovy", "terrific", "fantastic", "outstanding", "bravo", "well done", "tremendous", "brilliant", "rock on"]
    `say "#{insults.sample}"` if genre == "insult"
    `say "#{compliments.sample}"` if genre == "compliment"
  end

  def welcome
    puts colorize(logo, RED)
    puts "Welcome to Karma to Burn.\nWhat is your first name?"
    `say "Welcome!"`
    entered_name = STDIN.gets.chomp.capitalize
    puts "Hello, #{entered_name}. What is your date of birth(mm-dd-yyyy)?"
    entered_date_of_birth = STDIN.gets.chomp.split('-')
    month = entered_date_of_birth[0]
    day = entered_date_of_birth[1]
    year = entered_date_of_birth[2]
    entered_date_of_birth = "#{year}-#{"%02d" % month.to_i}-#{"%02d" % day.to_i}"
    generate_greeting(entered_name, entered_date_of_birth)
  end

  def generate_greeting(name, date_of_birth)
    if (User.where(name: name).exists? && User.where(date_of_birth: date_of_birth).exists?)
      @current_user = User.where(name: name, date_of_birth: date_of_birth).first
      puts "Welcome back, #{name}.\n"
      check_in
    else
      @current_user = User.create(name: name, date_of_birth: date_of_birth)
      create_daily_check_in_instance
      instructions
    end
  end

  def check_in
    last_check_in = @current_user.daily_check_ins.last.date
    if last_check_in.to_s == DailyCheckIn.date
      create_daily_check_in_instance
      puts "Back so soon?\nEnter p to view your progress. Enter s to hit the Karma Store. Press enter to exit."
      response = STDIN.gets.chomp.downcase
      progress if response == "p"
      store if response == "s"
      if response != "p" && response != "s"
        puts "Goodbye"
        `say "Goodbye"`
        exit
      end
    else
      create_daily_check_in_instance
      instructions
    end
  end

  def create_daily_check_in_instance
    @current_daily_check_in = DailyCheckIn.new(:date => DailyCheckIn.date, :physiological_points => 0, :safety_points => 0, :esteem_points => 0, :love_points => 0, :transcendence_points => 0, :user_id => @current_user.id, :spent_points => 0, :earned_points => 0)
  end

  def instructions
    puts colorize("Please assess the following statements. Enter true if you agree and false if you don't.", RED)
    puts "Press enter to continue."
    STDIN.gets
  end

  def analysis(response, category)
    if response == "true"
      commentary("compliment")
      @current_daily_check_in.increment! category
    elsif response == "false"
      commentary("insult")
      #the following line simply initiates the daily_check_in table. this prevents a nil no-method error from occurring if a user types false for every question.
      @current_daily_check_in.increment! category, by = 0
    end
  end

  def statements
    compiled_statements = [PHYSIOLOGICAL, SAFETY, ESTEEM, LOVE, TRANSCENDENCE]
    compiled_statements.each do | statements |
      statements.each do | statement |
        puts statement
        response = STDIN.gets.chomp.downcase
        if (response != "true" and response != "false")
          puts colorize("Enter true or false, imbecile.", RED)
          commentary("insult")
          redo
        end
        if statements == PHYSIOLOGICAL
          category = :physiological_points
        elsif statements == SAFETY
          category = :safety_points
        elsif statements == ESTEEM
          category = :esteem_points
        elsif statements == LOVE
          category = :love_points
        elsif statements == TRANSCENDENCE
          category = :transcendence_points
        end
        analysis(response, category)
      end
    end
  end

  def daily_points
    current_check_in = DailyCheckIn.where(:date => DailyCheckIn.date, :user_id => @current_user[:id]).first
    todays_points = current_check_in.physiological_points + current_check_in.safety_points + current_check_in.esteem_points + current_check_in.love_points + current_check_in.transcendence_points
    todays_points
  end

  def total_points
    current_check_in = DailyCheckIn.where(:user_id => @current_user[:id]).all
    past_daily_points = 0
    past_spent_points = 0
    counter = 0
    until counter == current_check_in.length do
      past_daily_points = past_daily_points + current_check_in[counter].earned_points
      past_spent_points = past_spent_points + current_check_in[counter].spent_points
      counter += 1
    end
    result = past_daily_points - past_spent_points
  end

  def total_minutes(karma_points)
    #i have arbitrarily assigned six minutes of leisure to one karma point. seems reasonable.
    total_time = karma_points * 6
  end

  def daily_report
    puts "You have earned #{colorize(daily_points, RED)} Karma Points today." if (daily_points > 1 || daily_points == 0)
    puts "You have earned #{colorize(daily_points, RED)} Karma Point today." if daily_points == 1
    @current_daily_check_in.update_attributes! :earned_points => daily_points
  end

  def store
    puts "You have a total of #{colorize(total_points, RED)} Karma Points.\nEnter s to spend Karma Points. Enter p to view your progress. Press enter to exit." if (total_points > 1 || daily_points == 0)
    puts "You have a total of #{colorize(total_points, RED)} Karma Point.\nEnter s to spend Karma Points. Enter p to view your progress. Press enter to exit." if total_points == 1 
    response = STDIN.gets.chomp.downcase
    progress if response == "p"
    puts "One Karma Point will get you six minutes of freedom. How many points would you like to spend?" if response == "s"
    if (response != "p" && response != "s")
      puts "Goodbye"
      `say "Goodbye"`
      exit 
    end
    redeemed_points = STDIN.gets.chomp.to_i
    if redeemed_points > total_points
      puts "You cannot spend more than you have earned, imbecile."
      commentary("insult")
      store
    elsif redeemed_points <= 0
      puts "You cannot spend 0 or less points, imbecile."
      commentary("insult")
      store
    else
      puts "Enter yes if would like to spend #{colorize(redeemed_points, RED)} Karma Points. Otherwise, just press enter." if redeemed_points > 1
      puts "Enter yes if would like to spend #{colorize(redeemed_points, RED)} Karma Point. Otherwise, just press enter." if redeemed_points == 1
      if redeemed_points == 0
        puts colorize("You can't spend 0 points, imbecile. Try again.", RED)
        commentary("insult")
        store
      end
      response = STDIN.gets.chomp.downcase
      if response == "yes"
        @current_daily_check_in.update_attributes! :spent_points => redeemed_points
        puts "You have #{colorize(total_minutes(redeemed_points), RED)} minutes to do whatever you desire. You have #{colorize("1", RED)} Karma Point remaining. Enjoy." if total_points == 1
        puts "You have #{colorize(total_minutes(redeemed_points), RED)} minutes to do whatever you desire. You have #{colorize(total_points, RED)} Karma Points remaining. Enjoy." if (total_points > 1 || total_points == 0)
        commentary("compliment")
        `say "Goodbye"`
        exit
      else
        store
      end
    end
  end

  def star_printer(amount_of_stars)
    stars = ""
    amount_of_stars.times do
      stars << "*"
    end
    stars
  end

  def progress
    daily_check_ins = DailyCheckIn.where(:user_id => @current_user[:id]).all
    counter = 0
    daily_total_points = 0
    balance = 0
    puts "\n   Date      Earned  Spent  Balance   Progress\n"
    until counter == daily_check_ins.length do
      date = daily_check_ins[counter].date
      daily_spent_points = daily_check_ins[counter].spent_points
      daily_total_points = daily_total_points.to_i + daily_check_ins[counter].earned_points.to_i
      balance = balance + daily_check_ins[counter].earned_points - daily_check_ins[counter].spent_points
      puts "#{date}  |  #{"%02d" % daily_check_ins[counter].earned_points}  |  #{"%02d" % daily_spent_points}  |   #{"%02d" % balance}   |  #{colorize(star_printer(balance), RED)} "
      counter += 1
    end
    puts "\nEnter s to go to the Karma Store or press enter to exit."
    response = STDIN.gets.chomp.downcase
    store if response == "s"
    if response != "s"
      puts "Goodbye"
      `say "Goodbye"`
      exit
    end
  end

  def run
    welcome
    DailyCheckIn.date
    statements
    daily_report
    store
  end

end