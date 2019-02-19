module BustimeHelper
  def bus_message
    next_busses = Bus.where('time > ?', Time.now.to_s(:time)).order(time: :asc)[0..5]
    message = ""
    next_busses.each do |next_bus|
      message << next_bus.time.strftime("%H:%M") + " 発 " + next_bus.goto + " 行 " + bus_time_later(next_bus.time).to_s + " 分後\n"
    end

    "このあとに来るバスは\n" + message.chomp
  end

  def bus_time_later(next_bus_time)
    timeNow = Time.now
    (next_bus_time.hour - timeNow.hour) * 60 + next_bus_time.min - timeNow.min
  end
end