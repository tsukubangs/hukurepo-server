module ApplicationHelper
  def japanese_gender(gender)
    return '男性' if gender == 'male'
    return '女性' if gender == 'female'
    return '性別不明'
  end

  def japanese_date(date)
    return "日時不明" if date.nil?
    "#{date.year}年#{date.month}月#{date.day}日 #{date.hour}時#{date.min}分"
  end

  def japanese_generation(age)
    return "年齢不詳" if age.nil?
    "#{age}代"
  end

  def truncated_comment(comment, limit)
    return "" if comment.nil?
    comment.truncate(limit)
  end

  def reply_status(responded)
    return responded ? "返信済み" : "未返信"
  end
end
