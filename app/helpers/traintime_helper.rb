module TraintimeHelper
  require 'open-uri'

  def train_message
    url = "http://www.ekikara.jp/newdata/ekijikoku/0101013/up1_01217011.htm"

    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil,charset)

    hours = []
    doc.xpath('//td[@class="lowBg06"]').each do |node|
      tex =  node.css('span[@class="l"]').inner_text.to_i
      hours << tex unless tex == 0
    end

    minutes = []
    doc.xpath('//td[@class="lowBgFFF" or @class="lowBg12"]').each do |node|
      tex = node.css('span[@class="ll"]').inner_text.scan(/.{1,2}/)
      minutes << tex unless tex == ""
    end

    i = 0
    schedules = []
    hours.size.times do
      minutes[i].each do |minute|
        schedules.push(DateTime.parse("#{hours[i]}:#{minute} +0900"))
      end
      i = i + 1
    end

    timeNow = DateTime.parse(Time.now.to_s)
    start_index = schedules.bsearch_index { |time| time > timeNow }
    next_trains = schedules[start_index, 5]

    message = ""
    next_trains.each do |next_train|
      message << next_train.strftime("%H:%M") + " 発  " + train_time_later(next_train).to_s + " 分後\n"
    end

    "このあと\n大麻駅から出発する電車は\n" + message.chomp
    # message = <<~"EOS"
    #   このあと
    #   大麻駅から出発する電車は
    #   #{next_trains[0].try(:strftime, "%H:%M")} 発　#{train_time_later(next_trains[0])}分後
    #   #{next_trains[1].try(:strftime, "%H:%M")} 発　#{train_time_later(next_trains[1])}分後
    #   #{next_trains[2].try(:strftime, "%H:%M")} 発　#{train_time_later(next_trains[2])}分後
    #   #{next_trains[3].try(:strftime, "%H:%M")} 発　#{train_time_later(next_trains[3])}分後
    #   #{next_trains[4].try(:strftime, "%H:%M")} 発　#{train_time_later(next_trains[4])}分後
    # EOS
    # message.chomp
  end

  def train_time_later(next_train)
    unless next_train == nil
      timeNow = DateTime.parse(Time.now.to_s)
      (next_train.hour - timeNow.hour) * 60 + next_train.min - timeNow.min
    end
  end
end