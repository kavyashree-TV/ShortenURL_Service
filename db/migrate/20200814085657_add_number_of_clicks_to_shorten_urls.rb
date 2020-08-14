class AddNumberOfClicksToShortenUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :shorten_urls, :number_of_clicks, :integer
  end
end
