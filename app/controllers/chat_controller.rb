class ChatController < WebsocketRails::BaseController
  def initialize_session
    logger.debug("initialize chat controller")
  end

  def connect_user
    logger.debug("connected user")
  end

  def new_message
    log = Chatlog.new
    log.create(message)
    gid = message[:group_id]
    WebsocketRails["#{gid}"].trigger(:new_message, message)
  end
end
