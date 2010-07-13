class CreateActivityObjects < ActiveRecord::Migration
  def self.up
    create_table :activity_objects do |t|
      t.integer :activity_id
      t.string :type
      t.string :url_id
      t.string :title
      t.datetime :published_at
      t.timestamps
    end
    
    add_index :activity_objects, :activity_id
    add_index :activity_objects, :type
  end
  
  def self.down
    remove_index :activity_objects, :type
    remove_index :activity_objects, :activity_id

    drop_table :activity_objects
  end
end
