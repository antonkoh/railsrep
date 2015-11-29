class AddPublishedFlagToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.boolean :is_published, default: true
    end
    Post.update_all ["is_published = ?", true]
  end
end
