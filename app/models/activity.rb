class Activity < ActiveRecord::Base
  include ActionController::UrlWriter
  default_url_options[:host] = APP_CONFIG[:domain]

  attr_accessible :url_id, :published_at, :verb, :title, :summary, :lang
  attr_accessible :actor_attributes, :target_attributes, :object_attributes

  has_many :activity_objects, :dependent => :destroy

  has_one :actor
  has_one :object, :class_name => 'Obj'
  has_one :target

  belongs_to :user

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

  def to_json
    a = {
      :id => activity_url(self),
      :permalinkUrl => activity_url(self),
      :title => self.title,
      :summary => self.summary,
      :postedTime => self.published_at.to_s(:w3cdtf),
      :actor => {
         :id => self.actor.url_id,
         :title => self.actor.title,
       },
       :object => {
         :id => self.object.url_id,
         :title => self.object.title,
         :objectType => self.object.object_type
       }
    }
    
    if self.target.present?
      a[:target] = {
        :id => self.target.url_id,
        :title => self.target.title,
        :objectType => self.target.object_type
      }
    end

    return JSON.pretty_generate({
      :data => {
        :lang => "en-US",
        :id => self.id,
        :items => [ a ]
      }
    }.stringify_keys)
  end

  def to_xml
    builder = Builder::XmlMarkup.new(:indent => 2)
    builder.entry do |b|
      b.id activity_url(self)
      b.permalink activity_url(self)
      b.published self.published_at.to_s(:w3cdtf)
      b.title self.title
      b.summary self.summary
      b.author do
        b.id self.actor.url_id
        b.title self.actor.title
      end
      b.activity :verb, self.verb
      b.activity :actor do
        b.id self.actor.url_id
        b.title self.actor.title, :type => 'text'
      end
      b.activity :object do
        b.id self.object.url_id
        b.title self.object.title, :type => 'text'
        b.activity :"object-type", self.object.object_type
      end

      if self.target.present?
        b.activity :target do
          b.id self.target.url_id
          b.title self.target.title, :type => 'text'
          b.activity :"object-type", self.target.object_type
        end
      end
    end
  end
end
