class Chatlog < ActiveRecord::Base
  def create(message)
    Chatlog.create(username: message[:name], message: message[:body], url: message[:group_id])
  end
end
