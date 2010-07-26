module ActivitiesHelper
  def activity_to_sentence(activity)
    [
      link_to(activity.object.title, activity_path(activity)),
      "- #{time_ago_in_words published_at} ago",
      content_tag(:br),
      link_to(activity.actor.title, activity.actor.url_id),
      "| #{activity.verb} |",
      link_to(activity.object.object_type, activity.object.url_id)
    ]
  end
end
