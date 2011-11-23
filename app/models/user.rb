class User < ActiveRecord::Base
  validates :first_name, :last_name, :username, :password, presence: true

  def self.authenticate(username, password)
    find_by_username_and_password(username, password)
  end

  def name
    first_name + " " + last_name
  end
end
