class CreateCommentSubscriptions < ActiveRecord::Migration
  def change
    create_table :comment_subscriptions do |t|
      t.belongs_to :post, index: true
      t.belongs_to :user, index:true
      t.timestamps null: false
    end
  end
end
