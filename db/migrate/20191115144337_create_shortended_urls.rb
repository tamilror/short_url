class CreateShortendedUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :shortended_urls do |t|
      t.text :original_url
      t.string :short_url
      t.timestamps
    end
  end
end
