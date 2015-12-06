class AddIsActiveToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :is_active, default: true, null: false
    end
    User.update_all ['is_active = ?', true]
  end
end
