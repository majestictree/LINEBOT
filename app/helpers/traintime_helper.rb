module TraintimeHelper
  require 'open-uri'

  def train_message
    url = "http://www.ekikara.jp/newdata/ekijikoku/0101013/up1_01217011.htm"
    html = open(url).read
    doc = Nokogiri::HTML.parse(html, nil, "CP932")

    hours = doc.xpath('//td[@class="lowBg06"]').map { |node|
      node.css('span[@class="l"]').inner_text }
    hours.delete("")

    minutes = doc.xpath('//td[@class="lowBgFFF" or @class="lowBg12"]').map { |node|
      node.css('span[@class="ll"]').inner_text.scan(/.{1,2}/) }
    minutes.delete("")

    bound_for = doc.xpath('//td[@class="lowBgFFF" or @class="lowBg12"]').map do |node|
      node.css('span[@class="s"]').map { |c| c.inner_text }
    end
    bound_for.flatten!.delete("◆")

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
      message << "#{m[0].strftime("%H:%M")}発  [#{m[1]}]  #{train_time_later(m[0])}分後\n"
    end

    "このあと\n大麻駅から出発する電車は\n" + message.chomp
  end

  def train_time_later(next_train)
    unless next_train == nil
      timeNow = DateTime.parse(Time.now.to_s)
      (next_train.hour - timeNow.hour) * 60 + next_train.min - timeNow.min
    end
  end
end