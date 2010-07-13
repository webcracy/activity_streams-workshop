class Activity < ActiveRecord::Base
  attr_accessible :url_id, :published_at, :verb, :title, :body, :lang

  has_many :activity_objects, :dependent => :destroy

  has_one :actor
  has_one :object, :class_name => 'Obj'
  has_one :target
end
