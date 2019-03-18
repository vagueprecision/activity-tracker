class ActivityWithCountPresenter < BasePresenter
  def initialize(activity_with_count, view)
    @view = view
    @id = activity_with_count.first.first
    @name = activity_with_count.first.second
    @unit = activity_with_count.first.third
    @count = activity_with_count.second
  end

  def id
	  @id
  end

  def name
	  @name
  end

  def count
    h.number_with_precision(@count, precision: 2, strip_insignificant_zeros: true)
  end

  def unit
    @unit
  end

  def title
    "#{name} - #{h.pluralize(count, unit)}"
  end


end
