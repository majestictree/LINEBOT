module BustimeHelper
  def bus_message
    next_bus = Bus.where('time > ?', Time.now.to_s(:time)).order(time: :asc)[0..5]
    message = <<~"EOS"
      このあとに来るバスは
      #{next_bus[0].time.strftime("%H:%M")} 発 #{next_bus[0].goto} #{bus_time_later(next_bus[0].time)}分後
      #{next_bus[1].time.strftime("%H:%M")} 発 #{next_bus[1].goto} #{bus_time_later(next_bus[1].time)}分後
      #{next_bus[2].time.strftime("%H:%M")} 発 #{next_bus[2].goto} #{bus_time_later(next_bus[2].time)}分後
      #{next_bus[3].time.strftime("%H:%M")} 発 #{next_bus[3].goto} #{bus_time_later(next_bus[3].time)}分後
      #{next_bus[4].time.strftime("%H:%M")} 発 #{next_bus[4].goto} #{bus_time_later(next_bus[4].time)}分後
    EOS
    message.chomp
  end

  def bus_time_later(next_bus_time)
    timeNow = Time.now
    (next_bus_time.hour - timeNow.hour) * 60 + next_bus_time.min - timeNow.min
  end
end