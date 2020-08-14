class CreateShortenUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shorten_urls do |t|
      t.text :original_url
      t.string :shortened_url
      t.string :sanitize_url
      t.datetime :expire_on
      t.timestamps
    end
  end
end
