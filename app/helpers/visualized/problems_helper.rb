module Visualized::ProblemsHelper

  def format_date(date)
    unless date.nil?
      "#{date.year}/#{date.month}/#{date.day} #{date.hour}:#{date.min}"
    else
      "no data"
    end
  end

  def add_generation(age)
    unless age.nil?
      "#{age}代"
    else
      "no data"
    end
  end

end
