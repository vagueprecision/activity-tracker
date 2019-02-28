class GoalPresenter < BasePresenter
  def title
	  activity.name
  end

  def progress_class
	  return 'bg-success' if met? || on_track?
	  # how_far_behind < 2 weeks ? 'bg-warning' : 'bg-danger'
	  'bg-danger'
  end

  def progress_description
    "#{display_count} / #{display_target_with_unit}"
  end

  def activity_list_link
    if count.positive?
      h.link_to('List', goal_activities_path(self)) #(year, activity_id))
    end
    'LIST'
  end

  def progress_color_class
    met? ? 'text-success' : 'text-danger'
    # text-warning
  end

  def display_percent_complete
	  h.number_with_precision(percent_complete, precision: 0, strip_insignificant_zeros: true)
  end

  def display_count
    h.number_with_precision(count, precision: 0, strip_insignificant_zeros: true)
  end

  def display_target
    h.number_with_precision(target, precision: 0, strip_insignificant_zeros: true)
  end

  def display_target_with_unit
	  h.pluralize(display_target, activity.unit)
  end
end
