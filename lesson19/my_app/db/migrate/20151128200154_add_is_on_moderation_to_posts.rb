class AddIsOnModerationToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.integer :status, null:false, default:0
    end

    Post.where(is_published: false).each {|p| p.draft!}
    Post.where(is_published: true).each {|p| p.approved!}

    change_table :posts do |t|
      t.remove :is_published
    end

  end
end
