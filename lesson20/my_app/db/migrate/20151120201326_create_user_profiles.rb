class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user, index:true
      t.timestamps null: false
    end
  end
end
