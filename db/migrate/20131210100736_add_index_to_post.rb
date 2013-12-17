class AddIndexToPost < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string
    add_index :posts, :slug, unique: true
    Post.all.map{|x| x.save!} #Update posts to create slug
  end
end
