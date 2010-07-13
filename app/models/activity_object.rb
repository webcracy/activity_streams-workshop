class ActivityObject < ActiveRecord::Base
  attr_accessible :activity_id, :type, :url_id, :title, :published_at, :object_type

  belongs_to :activity

  validates_format_of :url_id, :with => URI::regexp(%w(http https)), :allow_blank => true
end
