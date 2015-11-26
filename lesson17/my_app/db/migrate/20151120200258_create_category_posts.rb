class CreateCategoryPosts < ActiveRecord::Migration
  def change
    create_table :category_posts do |t|
      t.belongs_to :category, index: true
      t.belongs_to :post, index:true
      t.timestamps null: false
    end
  end
end
