class DropJoinTable < ActiveRecord::Migration
  def change
    drop_table :projects
  end
end
