require 'line/bot'

class WebhooksController < ApplicationController
  protect_from_forgery expect: [:callback, :push]

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      error 400 do 'Bad Request' end
    end

    events = client.parse_events_from(body)
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message['text'] == "ごみ"
            message = {
              type: 'text',
              text: notice_message
            }
            client.reply_message(event['replyToken'], message)
          else
            message = {
              type: 'text',
              text: event.message['text']
            }
            client.reply_message(event['replyToken'], message)
          end
        end
      end
    }

    head :ok
  end

  def push
    def push_ids
      ENV['PUSH_TO_ID'].split(',')
    end

    begin
      message = {
        type: 'text',
        text: notice_message
      }
      push_ids.each { |id| client.push_message(id, message) }

    rescue => e
      puts "batch exec error ..."
      p e
    end
    head :ok
    puts "========OK========"
  end
  

  private

  def client
    @client ||= Line::Bot::Client.new{ |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
  
end
