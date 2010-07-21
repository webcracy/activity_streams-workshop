class AddIsPublicAndPublicNameToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :is_public, :boolean
    add_column :activities, :public_name, :string
  end

  def self.down
    remove_column :activities, :public_name
    remove_column :activities, :is_public
  end
end
