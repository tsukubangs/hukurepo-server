module ApplicationHelper
  def japanese_gender(gender)
    return '男性' if gender == 'male'
    return '女性' if gender == 'female'
    return 'その他'
  end

  def truncated_comment(comment, limit)
    return "" if comment.nil?
    comment.truncate(limit)
  end
end