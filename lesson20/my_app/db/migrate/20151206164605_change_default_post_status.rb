class ChangeDefaultPostStatus < ActiveRecord::Migration
  def change
    change_column_default :posts, :status, from: 0, to: 1
  end
end
