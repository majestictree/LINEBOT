module WebhooksHelper
  def target_day
    @target_day ||= Date.today
  end

  def burnable_garbage?
    target_day.tuesday? || target_day.friday?
  end

  def recyclable_garbage?
    target_day.monday?
  end

  def bottle_can_garbage?
    target_day.monday?
  end

  # def not_burnable_garbage?
  #   now = target_day
  #   now.saturday? && now.mweek == 2
  # end

  def check
    return :burnable_garbage     if burnable_garbage?
    return :recyclable_garbage   if recyclable_garbage?
    return :bottle_can_garbage   if bottle_can_garbage?
    # return :not_burnable_garbage if not_burnable_garbage?
    :none
  end

  def notice_message
    message = case check
    when :burnable_garbage     then '燃えるゴミの日です'
    when :recyclable_garbage   then '資源ごみ(古紙)の日です'
    when :bottle_can_garbage   then '缶・ビンの日です'
    # when :not_burnable_garbage then '不燃ごみの日です'
    else '特に出せるゴミはありません'
    end
    "今日(#{target_day.strftime("%m月%d日 %a")})は、#{message}"
  end
end
