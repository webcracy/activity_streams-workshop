class AddPermalinkToActivities < ActiveRecord::Migration
  def self.up
    add_column :activities, :permalink, :string
  end

  def self.down
    remove_column :activities, :permalink
  end
end
