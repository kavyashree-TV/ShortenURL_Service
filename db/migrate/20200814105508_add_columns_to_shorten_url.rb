class AddColumnsToShortenUrl < ActiveRecord::Migration[5.1]
  def change
    add_column :shorten_urls, :ip_address, :integer
    add_column :shorten_urls, :country, :string
  end
end
