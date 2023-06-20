class ArticleChannel < ApplicationCable::Channel
  def subscribed
    return unless params[:article_id].present?

    stream_from "ArticleChannel-#{params[:article_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
