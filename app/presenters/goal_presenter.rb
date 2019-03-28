class GoalPresenter < BasePresenter
  def initialize(model, view, most_recent_date)
    @most_recent_date = most_recent_date
    super(model, view)
  end

  def title
	  activity.name
  end

  def progress_description
    "#{display_count} / #{display_target_with_unit}"
  end

  def activity_list(url)
    if count.positive?
      h.link_to(h.image_tag(h.image_path('list_32.png'), size:'16x16'), url)
    end
  end

  def progress_class
    return 'bg-success' if current_progress == UserGoal::COMPLETE || current_progress == UserGoal::ON_TRACK
    return 'bg-warning' if current_progress == UserGoal::SLIGHTLY_BEHIND
	  'bg-danger'
  end

  def progress_color_class
    return 'text-success' if current_progress == UserGoal::COMPLETE || current_progress == UserGoal::ON_TRACK
    return 'text-warning' if current_progress == UserGoal::SLIGHTLY_BEHIND
    'text-danger'
  end

  def display_percent_complete
	  h.number_with_precision(percent_complete, precision: 0, strip_insignificant_zeros: true)
  end

  def display_count
    h.number_with_precision(count, precision: 2, strip_insignificant_zeros: true)
  end

  def display_target
    h.number_with_precision(target, precision: 2, strip_insignificant_zeros: true)
  end

  def display_target_with_unit
	  h.pluralize(display_target, activity.unit)
  end

  def display_date
    'as of: ' + @most_recent_date.strftime('%-m/%-d').to_s if @most_recent_date
  end
end
