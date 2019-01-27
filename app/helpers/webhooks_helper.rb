module WebhooksHelper
  # def target_day
  #   @target_day ||= Date.today
  # end

  def burnable_garbage?
    @target_day.tuesday? || @target_day.friday?
  end

  def recyclable_garbage?
    @target_day.wednesday?
  end

  def bottle_can_garbage?
    @target_day.monday?
  end

  def not_burnable_garbage?
    now = @target_day
    now.wednesday? && mweek(now) == 3
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
      "今日(#{@target_day.strftime("%m月%d日 %a")})は、#{message}"
    elsif day == 'tomorrow'
      @target_day = Date.tomorrow
      "明日(#{@target_day.strftime("%m月%d日 %a")})は、#{message}"
    end
  end
  
  def message
    case check
      when :burnable_garbage     then '燃えるゴミとスプレー缶類を捨てれます'
      when :recyclable_garbage   then '雑がみが捨てれます'
      when :bottle_can_garbage   then '缶・ビン・ペットボトルを捨てれる日です'
      when :not_burnable_garbage then '不燃ごみ・乾電池・ライターを捨てれる日です'
    else '特に出せるゴミはありません'
    end
  end

  def mweek(now)
    (now.day + 6 + (self - self.day + 1).wday) / 7
  end
end
