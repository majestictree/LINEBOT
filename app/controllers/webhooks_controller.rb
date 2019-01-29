require 'line/bot'
class WebhooksController < ApplicationController
  protect_from_forgery expect: [:callback, :push]

  def callback
    events.each { |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message['text'] == "ごみ"
            reply_message_to(event, notice_message('tomorrow'))
          else
            reply_message_to(event, event.message['text'])
          end
        end
      end
    }
    head :ok
    puts "=========OK========"
  end

  def push
    begin
      message = text_message(notice_message)
      push_ids.each { |id| client.push_message(id, message) }
    rescue => e
      puts "batch exec error ..."
      p e
    end
    head :ok
    puts "========OK========"
  end
end
