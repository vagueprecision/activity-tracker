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

  # sorting
  def sorting_order(column_name)
    case column_name
    when 'name'
      activity.name.downcase
    when 'progress' # High to low
      -percent_complete
    else # magic
      magic
    end
  end

  def magic
    score = 0

    # higher if performed count in an ideal world this is LOGGED count...don't have count of user_activity TODO
    score += count

    # higher if performed more recently
    days_since = (Time.now.to_date - (@most_recent_date || 1.year.ago).to_date).to_i
    score += case days_since
    when 0 #not likely to modify again today, but higher than > 90 days
      10
    when 1...8
      50
    when 8...14
      30
    when 14...30
      20
    when 30...60
      5
    when 60..90
      2
    else # greater than 3 months
      0
    end

    # from results, prioritize by how far behind the user is
    score += 8 if current_progress == UserGoal::SLIGHTLY_BEHIND
    score += 20 if current_progress == UserGoal::WAY_BEHIND

    # invert since higher scores go last
    score *= -1

    # tie breaker...by name
    score += activity.name.upcase.ord.to_d / 100
  end
end
