module ApplicationHelper
  def simple_time(time)
    time.strftime("%Y-%m-%d　%H:%M　")
  end

  def date_format(datetime)
      time_ago_in_words(datetime) + '前'
  end
  
end
