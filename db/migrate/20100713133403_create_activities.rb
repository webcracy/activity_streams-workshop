class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.integer :user_id
      t.string :url_id
      t.string :verb
      t.string :title
      t.text :body
      t.string :lang
      t.datetime :published_at
      t.timestamps
    end

    add_index :activities, :user_id
  end
  
  def self.down
    remove_index :activities

    drop_table :activities
  end
end
