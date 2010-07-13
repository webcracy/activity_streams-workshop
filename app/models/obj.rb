class Obj < ActivityObject
  def self.to_select
    [
      ['PHOTO', "http://activitystrea.ms/schema/1.0/photo"]
    ]
  end
end
