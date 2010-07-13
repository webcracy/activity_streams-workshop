class Activity < ActiveRecord::Base
  attr_accessible :url_id, :published_at, :verb, :title, :summary, :lang
  attr_accessible :actor_attributes, :target_attributes, :object_attributes

  has_many :activity_objects, :dependent => :destroy

  has_one :actor
  has_one :object, :class_name => 'Obj'
  has_one :target

  validates_presence_of :actor
  validates_presence_of :verb
  validates_presence_of :object
  validates_presence_of :published_at

  accepts_nested_attributes_for :actor, :object, :target, :reject_if => proc { |p| p['url_id'].blank? }

  def self.verbs_to_select
    [
      ['POST', "http://activitystrea.ms/schema/1.0/post"]
    ]
  end
end
