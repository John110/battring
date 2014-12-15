class @ChatClass
  constructor: (url, useWebsocket) ->
    # これがソケットのディスパッチャー
    group_id = $('#group_id').text()
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @channel = @dispatcher.subscribe(group_id)
    console.log(url)
    # イベントを監視
    @bindEvents()

  bindEvents: () =>
    # 送信ボタンが押されたらサーバへメッセージを送信
    $('#send').on 'click', @sendMessage
    $("#msgbody").on "keypress",(e) =>
      if e.keyCode == 13
        @sendMessage(e)
        return false
    # サーバーからnew_messageを受け取ったらreceiveMessageを実行
    @dispatcher.bind 'new_message', @receiveMessage
    @channel.bind 'new_message', @receiveMessage

  sendMessage: (event) =>
    # サーバ側にsend_messageのイベントを送信
    # オブジェクトでデータを指定
    user_name = $('#username').text()
    msg_body = $('#msgbody').val()
    group_id = $('#group_id').text()
    @dispatcher.trigger 'new_message', { name: user_name , body: msg_body , group_id: group_id }
    $('#msgbody').val('')
    document.getElementById("chatbox").scrollTop = document.getElementById("chatbox").scrollHeight
    document.chatform.chattext.focus()

  receiveMessage: (message) =>
    console.log message
    # 受け取ったデータをappend
    $('#chat').append "#{message.name}  「#{message.body}」<br/>"
    document.getElementById("chatbox").scrollTop = document.getElementById("chatbox").scrollHeight

$ ->
  window.chatClass = new ChatClass($('#chat').data('uri'), true)
