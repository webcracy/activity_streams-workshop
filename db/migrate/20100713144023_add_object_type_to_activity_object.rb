class AddObjectTypeToActivityObject < ActiveRecord::Migration
  def self.up
    add_column :activity_objects, :object_type, :string
  end

  def self.down
    remove_column :activity_objects, :object_type
  end
end
