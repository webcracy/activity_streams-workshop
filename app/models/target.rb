class Target < ActivityObject
  def self.to_select
    [
      ['PHOTO-ALBUM', 'http://activitystrea.ms/schema/1.0/photo-album']
    ]
  end
end
