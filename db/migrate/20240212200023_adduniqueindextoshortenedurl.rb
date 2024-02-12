class Adduniqueindextoshortenedurl < ActiveRecord::Migration[7.0]
  def change
    add_index :urls, :shortened, unique: true
  end
end
