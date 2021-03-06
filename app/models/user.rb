class User < ActiveRecord::Base
  attr_accessor :current_user
  has_many :daily_check_ins, :dependent => :destroy
  validates_uniqueness_of :name, message: "must be unique"
end
