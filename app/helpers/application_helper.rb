# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def current_tab(controllername)
    if controller_name == controllername then
      'current'
    else
      ''
    end
  end
  
  def dotify(string, length)
    if string and string.length > length
      string[0..(length-3)] + "..." 
    else
      string
    end
  end

  def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)
     from_time = from_time.to_time if from_time.respond_to?(:to_time)
     to_time = to_time.to_time if to_time.respond_to?(:to_time)
     distance_in_minutes = (((to_time - from_time).abs)/60).round
     distance_in_seconds = ((to_time - from_time).abs).round

     case distance_in_minutes
       when 0..1            then "Just now"
       when 2..44           then "#{distance_in_minutes} minutes ago"
       when 45..89          then '1 hour ago'
       when 90..1439        then "#{(distance_in_minutes.to_f / 60.0).round} hours ago"
       when 1440..2879      then '1 day ago'
       when 2880..43199     then "#{(distance_in_minutes / 1440).round} days ago"
       when 43200..86399    then '1 month ago'
       when 86400..525959   then "#{(distance_in_minutes / 43200).round} months ago"
       when 525960..1051919 then '1 year ago'
       else                      "#{(distance_in_minutes / 525960).round} years ago"
     end
  end
   
   def distance_of_day_in_word(from_time)
     from_time = from_time.to_time if from_time.respond_to?(:to_time)
     to_time = Time.now.end_of_day
     distance_in_days = ((to_time - from_time).abs/60/60/24).round
     
     case distance_in_days
     when 0
      "Today"
    when 1
      "Yesterday"
    when 2
      "2 days ago"
    else 
      from_time.strftime("%d/%m/%Y")
     end
   end
   
   def distance_of_day_in_days(from_time, to_time = 0, include_seconds = false)
     from_time = from_time.to_time if from_time.respond_to?(:to_time)
     to_time = to_time.to_time if to_time.respond_to?(:to_time)
     distance_in_minutes = (((to_time - from_time).abs)/60).round
     distance_in_seconds = ((to_time - from_time).abs).round

     case distance_in_minutes
       when 0..1            then "Just now"
       when 2..44           then "#{distance_in_minutes} minutes"
       when 45..89          then '1 hour ago'
       when 90..1439        then "#{(distance_in_minutes.to_f / 60.0).round} hours ago"
       when 1440..2879      then '1 day ago'
       when 2880..43199     then "#{(distance_in_minutes / 1440).round} days ago"
       else
         "#{(distance_in_minutes / 1440).round} days ago"
     end
   end
end
