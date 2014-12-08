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
    # サーバーからnew_messageを受け取ったらreceiveMessageを実行
    @dispatcher.bind 'new_message', @receiveMessage
    @channel.bind 'new_message', @receiveMessage

  sendMessage: (event) =>
    # サーバ側にsend_messageのイベントを送信
    # オブジェクトでデータを指定
    user_name = $('#username').text()
    msg_body = $('#msgbody').val()
    group_id = $('#group_id').text()
    @dispatcher.trigger 'new_message', { name: user_name , body: msg_body , group_id: group_id}
    $('#msgbody').val('')

  receiveMessage: (message) =>
    console.log message
    # 受け取ったデータをappend
    $('#chat').append "#{message.name}  「#{message.body}」<br/>"

$ ->
  window.ChatClass = new ChatClass($('#chat').data('uri'), true)
  $(document).on "keypress", "input:not(.allow_submit)", (event) -> event.which != 13