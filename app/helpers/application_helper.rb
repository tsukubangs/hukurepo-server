module ApplicationHelper
  def japanese_gender(gender)
    return '男性' if gender == 'male'
    return '女性' if gender == 'female'
    return 'その他'
  end

  def japanese_date(date)
    return "不明" if date.nil?
    "#{date.year}年#{date.month}月#{date.day}日 #{date.hour}時#{date.min}分"
  end

  def japanese_generation(age)
    return "不詳" if age.nil?
    "#{age}代"
  end

  def truncated_comment(comment, limit)
    return "" if comment.nil?
    comment.truncate(limit)
  end
end
