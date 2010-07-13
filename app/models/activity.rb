class Activity < ActiveRecord::Base
  attr_accessible :url_id, :published_at, :verb, :title, :summary, :lang

  has_many :activity_objects, :dependent => :destroy

  has_one :actor
  has_one :object, :class_name => 'Obj'
  has_one :target

  accepts_nested_attributes_for :actor, :object, :target

  def self.verbs_to_select
    [
      ['POST', "http://activitystrea.ms/schema/1.0/post"]
    ]
  end
end
