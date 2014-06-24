class AddPublishedToMovies < ActiveRecord::Migration
  def change
  	add_column :movies, :published, :boolean, nil: false, defalut: false
  end
end
