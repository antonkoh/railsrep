class LinkUsersAndPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.belongs_to :user, index: true
    end
  end
end
