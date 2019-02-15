module BustimeHelper
  def bus_message
    next_bus = Bus.where('time > ?', Time.now.to_s(:time)).order(time: :asc)[0..5]
  
    message = <<~"EOS"
      このあとに来るバスは
      #{next_bus[0].time.strftime("%H:%M")} 発　#{next_bus[0].goto} 行き
      #{next_bus[1].time.strftime("%H:%M")} 発　#{next_bus[1].goto} 行き
      #{next_bus[2].time.strftime("%H:%M")} 発　#{next_bus[2].goto} 行き
      #{next_bus[3].time.strftime("%H:%M")} 発　#{next_bus[3].goto} 行き
      #{next_bus[4].time.strftime("%H:%M")} 発　#{next_bus[4].goto} 行き
    EOS
    message.chomp
  end
end