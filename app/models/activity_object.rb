class ActivityObject < ActiveRecord::Base
  attr_accessible :activity_id, :type, :url_id, :title, :published_at

  belongs_to :activity
end
