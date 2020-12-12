module GarbageHelper
  def burnable_garbage?
    @target_day.monday? || @target_day.thursday?
  end

  def recyclable_garbage?
    @target_day.friday?
  end

  def bottle_can_garbage?
    @target_day.tuesday?
  end

  def not_burnable_garbage?
    @target_day.wednesday?
  end

  def check
    return :burnable_garbage     if burnable_garbage?
    return :recyclable_garbage   if recyclable_garbage?
    return :bottle_can_garbage   if bottle_can_garbage?
    return :not_burnable_garbage if not_burnable_garbage?
    :none
  end

  def notice_message(day = 'today')
    if day == 'today'
      @target_day = Date.today
      "(#{@target_day.strftime("%m月%d日 %a")})は、#{message}"
    elsif day == 'tomorrow'
      @target_day = Date.today + 3
      "明日(#{@target_day.strftime("%m月%d日 %a")})は、#{message}"
    end
  end

  def message
    case check
      when :burnable_garbage     then '燃えるゴミを捨てれます'
      when :recyclable_garbage   then '資源プラスチック類が捨てれます'
      when :bottle_can_garbage   then '缶・ビン・ペットボトルを捨てれる日です'
      when :not_burnable_garbage then '不燃ごみを捨てれる日です'
    else '特に出せるゴミはありません'
    end
  end

  def mweek(now)
    (now.day + 6 + (self - self.day + 1).wday) / 7
  end
end
