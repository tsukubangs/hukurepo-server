module Visualized::ProblemsHelper

  def format_date(date)
    return "no data" if date.nil?
    "#{date.year}年#{date.month}月#{date.day}日 #{date.hour}時#{date.min}分"
  end

  def add_generation(age)
    return "no data" if age.nil?
    "#{age}代"
  end

end
