class DropShortenedUrlsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :shortened_urls
  end
end
