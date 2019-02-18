require 'line/bot'
class WebhooksController < ApplicationController
  protect_from_forgery expect: [:callback, :push]

  def callback
    events.each do |event|
      case event.message['text']
      when "ごみ" then
        reply_message_to(event, notice_message('tomorrow'))
      when "帰る" then
        reply_message_to(event, bus_message)
      when "大麻" then
        reply_message_to(event, train_message)
      else
        reply_message_to(event, event.message['text'])
      end
    end
    head :ok
    puts '========OK========='
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
