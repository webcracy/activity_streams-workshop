class Obj < ActivityObject
  validates_presence_of :url_id

  def self.to_select
    [
      ['PHOTO', "http://activitystrea.ms/schema/1.0/photo"]
    ]
  end
end
