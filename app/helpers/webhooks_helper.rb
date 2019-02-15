module WebhooksHelper
  def client
    @client ||= Line::Bot::Client.new{ |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      # ローカル用
      # config.channel_secret = "[Channel secret]"
      # config.channel_token = "[アクセストークン(ろんぐターム)]"
    }
  end

  def events
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end
    client.parse_events_from(body)
  end

  def text_message(text)
    message = {
      type: 'text',
      text: text
    }
  end
  
  def reply_message_to(event, text)
    client.reply_message(event['replyToken'], text_message(text))
  end

  def push_ids
    ENV['PUSH_TO_ID'].split(',')
  end
end
