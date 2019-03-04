module TraintimeHelper
  require 'open-uri'

  def train_message_ooasa
    url = "https://roote.ekispert.net/ja/timetable/20070/50"
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    hours = []
    minutes = []
    doc.xpath('//*[@id="timetable_weekdays"]/table/tr').each do |node|
      hours << node.xpath('.//th').inner_text
      node.xpath('.//td/ul').each do |n|
        minutes << n.xpath('.//li/text()').map { |t| t.inner_text }
      end
    end

    bound_for = doc.xpath('//*[@id="timetable_weekdays"]/table/tr/td/ul/li/span').map do |node|
      node.inner_text
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
    some_bound_for = bound_for[start_index, 5]
    next_train_and_bound_for = next_trains.zip(some_bound_for)

    message = ""
    next_train_and_bound_for.each do |m|
      message << "#{m[0].strftime("%H:%M")}発  #{train_time_later(m[0])}分後  #{m[1]}\n"
    end

    "このあと\n大麻駅から出発する電車は\n" + message.chomp
  end

  def train_message_nopporo
    url = "https://roote.ekispert.net/ja/timetable/20429/50"
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end

    doc = Nokogiri::HTML.parse(html, nil, charset)

    hours = []
    minutes = []
    doc.xpath('//*[@id="timetable_weekdays"]/table/tr').each do |node|
      hours << node.xpath('.//th').inner_text
      node.xpath('.//td/ul').each do |n|
        minutes << n.xpath('.//li/text()').map { |t| t.inner_text }
      end
    end

    bound_for = doc.xpath('//*[@id="timetable_weekdays"]/table/tr/td/ul/li/span').map do |node|
      node.inner_text
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
    some_bound_for = bound_for[start_index, 5]
    next_train_and_bound_for = next_trains.zip(some_bound_for)

    message = ""
    next_train_and_bound_for.each do |m|
      message << "#{m[0].strftime("%H:%M")}発  #{train_time_later(m[0])}分後  #{m[1]}\n"
    end

    "このあと\n野幌駅から出発する電車は\n" + message.chomp
  end

  def train_time_later(next_train)
    unless next_train == nil
      timeNow = DateTime.parse(Time.now.to_s)
      (next_train.hour - timeNow.hour) * 60 + next_train.min - timeNow.min
    end
  end
end