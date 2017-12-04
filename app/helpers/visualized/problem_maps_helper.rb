module Visualized::ProblemMapsHelper
  def truncated_comment(comment)
    return "" if comment.nil?
    comment.truncate(60)
  end
end
