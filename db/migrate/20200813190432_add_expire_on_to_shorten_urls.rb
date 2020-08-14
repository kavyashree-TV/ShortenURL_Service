class AddExpireOnToShortenUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :shorten_urls, :expire_on, :datetime
  end
end
