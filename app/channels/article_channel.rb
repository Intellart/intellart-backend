class ArticleChannel < ApplicationCable::Channel
  def subscribed
    return unless params[:article_id].present?

    stream_from "ArticleChannel-#{params[:article_id]}"
  end

  def unsubscribed
    stop_all_streams
    Section.where(current_editor_id: current_user.id).each(&:unlock)
  end
end
